module ApplicationHelper
	DATASET_PATH = Rails.root.join("datasets/").to_s

	#Gives the pretty version of this relation
	def pretty_relation(relation, dataset_id)
		dataset = Dataset.find(dataset_id).name

		config = JSON.parse(IO.read(DATASET_PATH + dataset + "/config.json"))
		config["relations-pretty"][relation]
	end

	def flatten_errors(collection)
		errors = []
		collection.each do |ele|
			errors.push(ele.errors)
		end
		errors.flatten!
	end

end
