class CommentCountToInquiry < ActiveRecord::Migration
  def self.up
    add_column :inquiries, :comments_count, :string
  end

  def self.down
    remove_column :inquiries, :comments_count
  end
end
