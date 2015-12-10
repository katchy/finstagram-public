class CreateCitiesBuildings < ActiveRecord::Migration
    
   def change
       
        create_table :cities do |t|
            t.string :name
            t.string :country
            t.string :img_src
            t.date   :founded
            t.integer :population
            t.timestamps
        end
        
        create_table :buildings do |t|
            t.references :city
            t.string :name
            t.string :img_src
            t.integer :height_m
            t.date  :date_built
            t.boolean  :is_ugly
        end
   end#change
end#class