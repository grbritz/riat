class Sentence < ActiveRecord::Base
	self.primary_keys = [:sentence_id, :dataset_id]
	has_many :relation_instances, {dependent: :destroy, foreign_key: [:sentence_id, :dataset_id], classname: "RelationInstance"}
	belongs_to :dataset
end
