class AddUsersToCitiesBuildings < ActiveRecord::Migration
    
   def change
       
        change_table :cities do |t|
            t.references :user
        end
         
        change_table :buildings do |t|
            t.references :user
        end
   end#change
end#class