class Dataset < ActiveRecord::Base
	has_many :sentence, dependent: :destroy
	has_many :relation_instance, dependent: :destroy
	validates :name, uniqueness: true




	def get_results
		sentences = Sentence.includes(relation_instances: [:annotations]).where(dataset_id: self.id).load

		sentences = sentences.map do |sent|
			instances = sent.relation_instances.map do |rel_inst|
				annotations_summary = rel_inst.summarize_annotations
				rel_inst.serializable_hash.merge({annotations: rel_inst.annotations, annotations_summary: annotations_summary})
			end
			{sentence_id: sent.sentence_id, sentence: sent.sentence, relation_instances: instances}
		end
		{dataset_name: self.name, sentences: sentences}
	end
end
