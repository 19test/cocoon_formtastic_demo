class Task < ActiveRecord::Base
	belongs_to :project
	has_many :temps

	def done
		not temps.empty?
	end

	def done=(v)
		logger.info { "M v=#{v.inspect} M" }
		if v.to_i == 1
			temps = [ Temp.find_or_create_by_task_id(id) ]
		else
			logger.info { ">> FALSE " }
			temps = []
			Temp.delete_all("task_id='#{id}'")
		end
	end
end
