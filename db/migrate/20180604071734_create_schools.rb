class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.timestamps
      t.string :name
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :openings
      t.string :phone
      t.string :email
      t.integer :nb_student
      t.string :statust
      t.float :latitude
      t.float :longitude
    end
  end
end
