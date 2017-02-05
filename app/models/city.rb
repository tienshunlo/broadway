class City < ActiveRecord::Base
	has_many :district
	has_many :hospital
end
