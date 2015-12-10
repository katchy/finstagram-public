class City < ActiveRecord::Base
    
    has_many :buildings
    belongs_to :user
    
    def readable_founded_date
         self.founded.strftime("%B %e, %Y") # outputs something like December 24, 1986
    end
    
    # acts on one instance of the City class
    # acts on one city object
    def month
        self.founded.strftime("%B")
    end
    
end
