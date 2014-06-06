class RelationInstance < ActiveRecord::Base
	belongs_to :sentence, foreign_key: [:sentence_id, :dataset_id]
	belongs_to :dataset
	has_many :annotations, dependent: :destroy, class_name: "Annotation"
end
