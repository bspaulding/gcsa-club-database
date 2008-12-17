class Administrator < ActiveRecord::Base
  before_destroy :verify_admin_presence
  
  validates_presence_of :username
  validates_uniqueness_of :username
  
  def self.is_admin(username)
    if !username.index('@gordon.edu').nil?
      username = username.sub('@gordon.edu', '')
    end
    
    admins = Administrator.all(:conditions => {:username => username})
    if admins.size == 0
      return false
    end
    return true
  end
  
  private
    def verify_admin_presence
      one_left = Administrator.all.size == 1
      if one_left
        raise "You cannot delete the last administrator. Please add a new administrator before removing this one."
      end
    end
  
end
