#This module is intended to be used by the helpers for dataset experiments
#Include it in those experiments
# All experiments using BaseHelper must implement the get_dataset method
module BaseHelper

	#Gets the current sentence a user should annotate
	def get_sentence(user)
		sentence = session[:current_sentence].nil? ? new_sentence(user) : Sentence.includes("relation_instances").find(session[:current_sentence])
		if(!sentence.nil?)
			if(sentence.is_completed?(user))
				sentence = new_sentence(user)
			end
			session[:current_sentence] = sentence.to_param
		else
			session[:current_sentence] = nil
		end
		return sentence
	end

	def new_sentence(user)
		idsCompleted = UserSentenceCompleted.where(user_id:user.id, dataset_id: get_dataset.id).pluck(:sentence_id)
		if(!idsCompleted.empty?)
			idsCompletedTuple = arrToTuple(idsCompleted)
			Sentence.includes("relation_instances").where("sentences.dataset_id = '#{get_dataset.id}' AND sentences.sentence_id NOT IN #{idsCompletedTuple}").shuffle.first
		else
			Sentence.includes("relation_instances").where(dataset_id:get_dataset.id).shuffle.first
		end
	end

	# number of sentences completed by user
	def num_completed(user)
		UserSentenceCompleted.where(user_id:user.id, dataset_id: get_dataset.id).count
	end

	def total_sentences
		Sentence.where(dataset_id: get_dataset.id).count
	end

	#returns progress as a percentage rounded to nearest int
	def get_progress(user)
		Integer(num_completed(user).fdiv(total_sentences) * 100)
	end

	# Turns an array into a tuple
	def arrToTuple(arr)
		 "(" + arr.to_s.chop.reverse.chop.reverse + ")"
	end
end