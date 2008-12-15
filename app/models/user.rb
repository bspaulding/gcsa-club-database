require 'net/ldap'

class User
  
  def self.authenticate(username,password)
    # Check for, and add if neccessary, @gordon.edu to the username
    if username.downcase.index("@gordon.edu").nil?
      username += "@gordon.edu"
    end
    
    if password.length == 0
      return false
    else
      # Create the LDAP Connection and attempt to bind, sending back the result as true or false
      ldap = Net::LDAP.new
      ldap.host = "elder2.gordon.edu" #"199.97.45.206"
      ldap.port = 389
      ldap.auth username, password
      ldap.bind
    end
  end
  
  def self.find_by_email(email, username, password)
    if authenticate(username, password)
      # Check for, and add if neccessary, @gordon.edu to the username
      if username.downcase.index("@gordon.edu").nil?
        username += "@gordon.edu"
      end

      # Create the LDAP Connection and attempt to bind, sending back the result as true or false
      ldap = Net::LDAP.new
      ldap.host = "elder2.gordon.edu" #"199.97.45.206"
      ldap.port = 389
      ldap.auth username, password
      ldap.bind
      
      filter = Net::LDAP::Filter.eq( "cn", "#{email}*" )
      treebase = "ou=Students,ou=Gordon College,dc=gordon,dc=edu"
      attributes = ["givenname", "sn", "mail"]

      students = []
      ldap.search( :base => treebase, :filter => filter ) do |entry|
        unless entry['mail'].length == 0
          students << ["#{entry['givenname']} #{entry['sn']}", entry['mail'][0]]
        end
      end
      students
    end
  end
end