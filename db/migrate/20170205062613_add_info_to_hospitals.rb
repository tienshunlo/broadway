class AddInfoToHospitals < ActiveRecord::Migration
  def change
  	add_column :hospitals, :info_address, :string
  	add_column :hospitals, :info_tel, :string
  	add_column :hospitals, :info_others, :string
  end
end
