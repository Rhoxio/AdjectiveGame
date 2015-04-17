class Attack < ActiveRecord::Base
	belongs_to :character
	has_many :statuses

end
