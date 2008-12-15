class Group < ActiveRecord::Base
  has_and_belongs_to_many :categories
  
  named_scope :active, :conditions => {:active => true}
  
  validates_uniqueness_of :name
end
