class RelationInstance < ActiveRecord::Base
	belongs_to :sentence
	belongs_to :dataset
end
