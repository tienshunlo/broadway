class AddWebsiteToHospitals < ActiveRecord::Migration
  def change
  	add_column :hospitals, :website, :string
  end
end
