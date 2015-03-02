module SubDiff
  module Cache
    def cache(variables)
      existing = define_cached_instance_variables(variables)
      yield.tap { undefine_cached_instance_variables(existing) }
    end

    private

    def define_cached_instance_variables(variables)
      variables.inject({}) do |existing, (variable, value)|
        variable = "@#{variable}"
        cached = fetch_cached_instance_variable(variable)
        instance_variable_set(variable, value)
        existing.update(variable => cached)
      end
    end

    def fetch_cached_instance_variable(variable)
      if instance_variable_defined?(variable)
        instance_variable_get(variable)
      end
    end

    def undefine_cached_instance_variables(variables)
      variables.each do |variable, value|
        instance_variable_set(variable, value)
      end
    end
  end
end
