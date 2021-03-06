# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

class Post < ActiveRecord::Base
end

module Schema
  def self.create
    ActiveRecord::Migration.verbose = false

    ActiveRecord::Schema.define do
      create_table :posts, force: true do |t|
        t.string :title, null: false
        t.string :body, null: false
        t.timestamps null: false
      end
    end
  end
end
