class Building < ActiveRecord::Base
    
    belongs_to :city
    belongs_to :user
    
    validates :name, :city_id, :height_m, :date_built, presence: true
    
end