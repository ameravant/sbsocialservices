class InquiryMod < ActiveRecord::Migration
  def self.up
    remove_column :inquiries, :email
    remove_column :inquiries, :phone
    create_table :answers, :force => true do |t|
      t.string :inquiry_id
      t.text :answer
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
