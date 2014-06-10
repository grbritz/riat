class Sentence < ActiveRecord::Base
	self.primary_keys = :sentence_id, :dataset_id
	has_many :relation_instances, {dependent: :destroy, class_name: "RelationInstance", foreign_key: [:sentence_id, :dataset_id]}
	belongs_to :dataset
	validates :sentence_id, uniqueness: { scope: :dataset_id, message: "Sentence can be used once per dataset"}

	#Marks this sentence as completed for this user
	def complete_for(user)
		UserSentenceCompleted.create({sentence_id: self.sentence_id, user_id:user.id, dataset_id: self.dataset_id})
	end

	def is_completed?(user)
		UserSentenceCompleted.where(sentence_id: self.sentence_id, dataset_id: self.dataset_id, user_id: user.id).count == 1
	end
end
