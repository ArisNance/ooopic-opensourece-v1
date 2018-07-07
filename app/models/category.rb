class Category < ActiveRecord::Base
    
    has_many :photos
    
    def to_param
     "#{id} #{name}".parameterize
    end
end
