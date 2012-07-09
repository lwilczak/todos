class Todo < ActiveRecord::Base
  
  attr_accessible :content, :subject, :user, :priority_id

  validates :subject, :presence => true,
                    :length => { :minimum => 5 }
  validates :priority, :presence => true

  belongs_to :user
  belongs_to :priority
  
end
