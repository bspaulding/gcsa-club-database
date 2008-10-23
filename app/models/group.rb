class Group < ActiveRecord::Base
  has_and_belongs_to_many :categories
  
  validates_inclusion_of :kind, :in => ["club", "council", "cabinet", "publication"]
end
