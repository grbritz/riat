class Annotation < ActiveRecord::Base
	belongs_to :relation_instance, dependent: :destroy
end
