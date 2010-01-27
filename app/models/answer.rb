class Answer < ActiveRecord::Base
  belongs_to :inquiry
  validates_presence_of :answer, :message => "Please provide a response"
end