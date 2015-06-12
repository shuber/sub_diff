module SubDiff
  # This module allows classes to accept a {Builder} object as
  # an initializer argument and defines an `attr_reader` for it.
  #
  # It also delegates commonly used methods to the {Builder} instance.
  #
  # Used internally by {Adapter}, {Differ}, and {Sub}.
  #
  # @api private
  module Buildable
    attr_reader :builder

    def initialize(builder)
      @builder = builder
    end

    def self.included(base)
      base.extend(Forwardable)
      base.def_delegators(:builder, :diff_method, :differ, :string)
    end
  end
end
