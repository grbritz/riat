class Dataset < ActiveRecord::Base
	has_many :sentence, dependent: :destroy
	has_many :relation_instance, dependent: :destroy
	validates :name, uniqueness: true
end
