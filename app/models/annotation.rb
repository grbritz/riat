class Annotation < ActiveRecord::Base
	belongs_to :relation_instance, dependent: :destroy
	validates :annotation, presence: true, numericality: { only_integer: true, less_than: 3}
	validates :ambiguity_reason, presence: true, if: Proc.new { |a| a.annotation == 2 }
end
