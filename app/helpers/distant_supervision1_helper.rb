module DistantSupervision1Helper
	include BaseHelper
	
	def get_dataset
		@dataset ||= Dataset.find_by(name: "distant_supervision1")
	end
end
