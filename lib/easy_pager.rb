# frozen_string_literal: true

require 'easy_pager/version'
require 'easy_pager/active_record'
require 'easy_pager/configuration'

# EasyPager
module EasyPager
  extend Configuration
  class Error < StandardError; end
end

EasyPager.configure do |config|
  config.default_per = 25
end
