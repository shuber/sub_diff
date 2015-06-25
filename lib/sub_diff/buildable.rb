module SubDiff
  # This module allows classes to accept a {Factory} object as
  # an initializer argument and defines an `attr_reader` for it.
  #
  # It also delegates commonly used methods to the {Factory} instance.
  #
  # Used internally by {Builder}, {Differ}, and {Sub}.
  #
  # @api private
  module Buildable
    attr_reader :factory

    def initialize(factory)
      @factory = factory
    end

    def self.included(base)
      base.extend(Forwardable)
      methods = %i(adapter builder collection differ diff_method string)
      base.def_delegators(:factory, *methods)
    end
  end
end
