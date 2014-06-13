class Dataset < ActiveRecord::Base
	has_many :sentence, dependent: :destroy
	has_many :relation_instance, dependent: :destroy
	validates :name, uniqueness: true




	def annotation_results(export_type)
		case export_type
		when "hash"
			get_annotation_results_hash
		when "csv"
			get_annotation_results_csv
		end
	end


	def user_completion_results(export_type)
		user_num_completed = UserSentenceCompleted.select("user_id, count(*) as num_completed").where(dataset_id:self.id).group("user_id")
		num_sentences = Sentence.where(dataset_id: self.id).count
		case export_type
		when "hash"
			user_num_completed.map do |unc|
				unc.serializable_hash.merge({total_sentences: num_sentences})
			end
		when "csv"
			tmp = user_num_completed.map do |unc|
				[unc.user_id,unc.num_completed,num_sentences].join(",")
			end
			["user_id,num_completed,total_sentences"].concat(tmp).join("\n")
		end
	end


	private
		def get_annotation_results_hash
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

		def get_annotation_results_csv
			relation_instances = RelationInstance.includes(:annotations).where(dataset_id: self.id).load
			results = ["sentence_id,relation_instance_id,relation,is_expressed,is_not_expressed,not_sure_expressed,is_bad_pattern,total_anns"]
			tmp = relation_instances.map do |rel_inst|
				annotations_summary = rel_inst.summarize_annotations
				[rel_inst.sentence_id, rel_inst.id, rel_inst.relation].concat(annotations_summary.values).join(",")
			end
			results.concat(tmp).join("\n")
		end

end
