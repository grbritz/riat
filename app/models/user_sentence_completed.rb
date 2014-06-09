class UserSentenceCompleted < ActiveRecord::Base
	self.table_name = 'user_sentence_completed'
	self.primary_keys = :user_id, :dataset_id, :sentence_id
	belongs_to :user
	belongs_to :sentence, foreign_key: [:dataset_id, :sentence_id]
end
