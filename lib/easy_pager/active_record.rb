# frozen_string_literal: true

require 'easy_pager/active_record/base'

module EasyPager
  # EasyPager::ActiveRecord
  module ActiveRecord; end
end

ActiveSupport.on_load(:active_record) do
  extend EasyPager::ActiveRecord::Base
end
