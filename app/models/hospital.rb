class Hospital < ActiveRecord::Base
	belongs_to :city
	belongs_to :district
end
