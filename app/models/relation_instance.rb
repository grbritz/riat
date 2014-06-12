class RelationInstance < ActiveRecord::Base
	belongs_to :sentence, foreign_key: [:dataset_id, :sentence_id]
	belongs_to :dataset
	has_many :annotations, dependent: :destroy, class_name: "Annotation"

	# Summarizes the annotation results for this RelationInstance
	def summarize_annotations
		
		result = {is_expressed: 0, is_not_expressed: 0, not_sure_expressed: 0, is_bad_pattern: 0}
		self.annotations.each do |ann|
			case ann.annotation
			when 0
				result[:is_not_expressed] += 1
			when 1
				result[:is_expressed] += 1
			when 2
				result[:not_sure_expressed] += 1
			end

			if(!ann.is_bad_pattern.nil? && ann.is_bad_pattern)
				result[:is_bad_pattern] += 1
			end
		end
		result
	end
end
