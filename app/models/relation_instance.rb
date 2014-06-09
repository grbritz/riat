class RelationInstance < ActiveRecord::Base
	belongs_to :sentence, foreign_key: [:dataset_id, :sentence_id]
	belongs_to :dataset
	has_many :annotations, dependent: :destroy, class_name: "Annotation"
end
