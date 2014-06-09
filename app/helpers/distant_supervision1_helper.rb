module DistantSupervision1Helper


	def get_dataset
		Dataset.find_by(name: 'distant_supervision1')
	end

	#Gets the current sentence a user should annotate
	def get_sentence(user)
		dataset = get_dataset
		idsCompleted = UserSentenceCompleted.where(user_id:user.id, dataset_id: dataset.id).pluck(:sentence_id)
		if(!idsCompleted.empty?)
			idsCompletedTuple = arrToTuple(idsCompleted)
			Sentence.includes("relation_instances").where("sentences.dataset_id = '#{dataset.id}' AND sentences.sentence_id NOT IN #{idsCompletedTuple}").first
		else
			Sentence.includes("relation_instances").where(dataset_id:dataset.id).first
		end
	end

	# Turns an array into a tuple
	def arrToTuple(arr)
		 "(" + arr.to_s.chop.reverse.chop.reverse + ")"
	end

end
