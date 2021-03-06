class Task < ActiveRecord::Base
	belongs_to :project
	has_many :temps, dependent: :destroy
  	accepts_nested_attributes_for :temps, allow_destroy: true

	def done
		not temps.empty?
	end

	def done=(v)
		if v.to_i == 1
			temps = [ Temp.find_or_create_by_task_id(id) ]
		else
			Temp.delete_all(["task_id = ?", id])
		end
	end
end
