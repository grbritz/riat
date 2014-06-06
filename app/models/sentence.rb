class Sentence < ActiveRecord::Base
	has_many :relation_instances, dependent: :destroy
	belongs_to :dataset
end
