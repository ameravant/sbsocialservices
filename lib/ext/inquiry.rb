class Inquiry < ActiveRecord::Base
  validates_presence_of :inquiry, :message => "message can't be blank"
  default_scope :order => "created_at desc"
  has_many :answers
end