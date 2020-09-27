# frozen_string_literal: true

module EasyPager
  # EasyPager::Configuration
  module Configuration
    mattr_accessor :options

    self.options = { default_per: 25, max_per: nil }

    # @return [void]
    def configure
      yield self
    end

    # @param [Integer] limit_val
    # @return [Integer]
    # @raise [ArgumentError]
    def default_per=(limit_val)
      validate_limit_val(limit_val)

      options[:default_per] = limit_val
    end

    # @param [Integer] limit_val
    # @return [Integer]
    # @raise [ArgumentError]
    def max_per=(limit_val)
      validate_limit_val(limit_val)

      options[:max_per] = limit_val
    end

    private

    # @param [Integer] limit_val
    # @return [NilClass]
    # @raise [ArgumentError]
    def validate_limit_val(limit_val)
      raise ArgumentError unless limit_val.is_a?(Integer) && limit_val >= 0
    end
  end
end
