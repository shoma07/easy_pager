# frozen_string_literal: true

module EasyPager
  module ActiveRecord
    # EasyPager::ActiveRecord::Base
    module Base
      # @param [Integer] page_val
      # @return [ActiveRecord::Relation]
      def page(page_val = 1)
        page_val = page_val.to_i.positive? ? page_val.to_i : 1
        scope = current_scope || relation
        limit_val = EasyPager.options[:default_per]
        offset_val = page_val - 1 >= 0 ? (page_val - 1) * limit_val : 0
        scope.offset(offset_val).limit(limit_val)
      end

      # @param [Integer] limit_val
      # @return [ActiveRecord::Relation]
      # @return [NilClass]
      def per(limit_val = nil)
        max_per = EasyPager.options[:max_per]
        default_per = EasyPager.options[:default_per]
        limit_val = limit_val.to_i >= 0 ? limit_val.to_i : default_per
        limit_val = max_per if max_per && max_per.to_i > limit_val
        scope = current_scope || relation
        return unless scope.limit_value && scope.offset_value

        offset_val = (scope.offset_value / scope.limit_value) * limit_val
        scope.offset(offset_val).limit(limit_val)
      end

      # @return [Integer]
      # @return [NilClass]
      def current_page
        scope = current_scope || relation
        return unless scope.limit_value && scope.offset_value

        (scope.offset_value.to_i / scope.limit_value.to_i) + 1
      end

      # @return [Integer]
      # @return [NilClass]
      def total_pages
        scope = current_scope || relation
        return unless scope.limit_value && scope.offset_value

        (BigDecimal(scope.total_count) / BigDecimal(scope.limit_value)).ceil
      end

      # @return [Integer]
      # @return [NilClass]
      # @todo cache total count
      def total_count
        scope = current_scope || relation
        return unless scope.limit_value && scope.offset_value

        scope.except(:limit, :offset).count
      end
    end
  end
end
