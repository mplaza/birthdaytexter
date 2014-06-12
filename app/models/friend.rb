class Friend < ActiveRecord::Base
	belongs_to :user

	def convertdate
		newyear = Time.new.utc.year
		return "#{newyear}/#{monthbirth}/#{daybirth} 12:35:00"
	end
end
