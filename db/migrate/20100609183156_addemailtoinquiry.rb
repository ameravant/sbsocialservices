class Addemailtoinquiry < ActiveRecord::Migration
  def self.up
    add_column :inquiries, :email, :string
  end

  def self.down
    remove_column :inquiries, :email
  end
end
