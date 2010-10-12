module CommentExt
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def comment_extra_methods
      belongs_to :commentable, :polymorphic => true, :counter_cache => true
      profanity_filter :comment
      include CommentExt::InstanceMethods
    end
  end
  
  module InstanceMethods
  end
  
end
ActiveRecord::Base.send(:include, CommentExt)
Comment.send(:comment_extra_methods)