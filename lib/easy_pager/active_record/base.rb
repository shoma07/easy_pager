# frozen_string_literal: true

module EasyPager
  module ActiveRecord
    # EasyPager::ActiveRecord::Base
    module Base
      # @param [Integer] page_val
      # @return [ActiveRecord::Relation]
      # @raise [ArgumentError]
      def page(page_val)
        raise ArgumentError unless page_val.to_i.positive?

        limit_val = EasyPager.options[:default_per]
        (current_scope || relation).offset((page_val - 1) * limit_val).limit(limit_val)
      end

      # @param [Integer] limit_val
      # @return [ActiveRecord::Relation]
      # @raise [ArgumentError]
      def per(limit_val)
        raise ArgumentError unless limit_val.to_i.positive?

        limit_val = [EasyPager.options[:max_per] || limit_val, limit_val].min
        scope = current_scope || relation
        scope = scope.page(1) unless scope.limit_value
        scope.offset((scope.offset_value / scope.limit_value) * limit_val).limit(limit_val)
      end

      # @return [Integer, NilClass]
      def current_page
        scope = current_scope
        return unless !scope.nil? && scope.limit_value && scope.offset_value

        (scope.offset_value.to_i / scope.limit_value.to_i) + 1
      end

      # @return [Integer, NilClass]
      def total_pages
        scope = current_scope
        return unless !scope.nil? && scope.limit_value && scope.offset_value

        (BigDecimal(scope.total_count) / BigDecimal(scope.limit_value)).ceil
      end

      # @todo cache total count
      #
      # @return [Integer]
      def total_count
        (current_scope || relation).except(:limit, :offset).count
      end
    end
  end
end
