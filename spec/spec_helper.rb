if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start { add_filter('/vendor/bundle/') }
end

require File.expand_path('../../lib/sub_diff', __FILE__)

RSpec.configure do |config|
  config.filter_run :focus
  config.raise_errors_for_deprecations!
  config.run_all_when_everything_filtered = true
end

# RSpec matcher to spec delegations.
# Forked from https://gist.github.com/ssimeonov/5942729 with fixes
# for arity + custom prefix.
#
# Usage:
#
#     describe Post do
#       it { should delegate(:name).to(:author).with_prefix } # post.author_name
#       it { should delegate(:name).to(:author).with_prefix(:any) } # post.any_name
#       it { should delegate(:month).to(:created_at) }
#       it { should delegate(:year).to(:created_at) }
#       it { should delegate(:something).to(:'@instance_var') }
#     end
RSpec::Matchers.define :delegate do |method|
  match do |delegator|
    @prefix ||= nil
    @method = @prefix ? :"#{@prefix}_#{method}" : method
    @delegator = delegator

    if @to.to_s[0] == '@'
      # Delegation to an instance variable
      old_value = @delegator.instance_variable_get(@to)
      begin
        @delegator.instance_variable_set(@to, receiver_double(method))
        @delegator.send(@method) == :called
      ensure
        @delegator.instance_variable_set(@to, old_value)
      end
    elsif @delegator.respond_to?(@to, true)
      unless [0,-1].include?(@delegator.method(@to).arity)
        raise "#{@delegator}'s' #{@to} method does not have zero or -1 arity (it expects parameters)"
      end
      allow(@delegator).to receive(@to).and_return(receiver_double(method))
      @delegator.send(@method) == :called
    else
      raise "#{@delegator} does not respond to #{@to}"
    end
  end

  description do
    "delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  failure_message do |text|
    "expected #{@delegator} to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  failure_message_when_negated do |text|
    "expected #{@delegator} not to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  chain(:to) { |receiver| @to = receiver }
  chain(:with_prefix) { |prefix| @prefix = prefix || @to }

  def receiver_double(method)
    double('receiver').tap do |receiver|
      allow(receiver).to receive(method).and_return(:called)
    end
  end
end
