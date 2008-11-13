require 'net/ldap'

class User
  
  def self.authenticate(username,password)
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
  end
end