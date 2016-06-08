module EasyLogin
  module Config
    
    def self.salt=(salt)
      @@salt = salt
    end
    
    def self.salt
      @@salt
    end

  end
end
