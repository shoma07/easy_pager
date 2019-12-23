# frozen_string_literal: true

module EasyPager
  # EasyPager::Configuration
  module Configuration
    mattr_accessor :options

    self.options = {
      default_per: 25,
      max_per: nil
    }

    def configure
      yield self
    end

    # @param [Integer] limit_val
    # @return [Integer]
    def default_per=(limit_val)
      options[:default_per] = limit_val.to_i if limit_val.to_i >= 0
    end

    def max_per=(limit_val)
      options[:max_per] = limit_val.to_i if limit_val.to_i >= 0
    end
  end
end
