class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  belongs_to :person
  profanity_filter :comment
  validates_presence_of :comment
  validates_format_of :email, :with => /\A\S+\@\S+\.\S+\Z/, :allow_blank => true
  default_scope :order => "created_at"
end
