class Attack < ActiveRecord::Base
	belongs_to :character
	has_one :status

end
