class Administrator < ActiveRecord::Base
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
end
