#lib/tasks/new_dataset

desc "Creates local file structure for a new dataset; Generates default controller for an experiment with that dataset"
task :new_dataset, [:name] => :environment do |task, args|
	dataset = args[:name].underscore
	system "mkdir", "datasets/" + dataset
	system "mkdir", "datasets/" + dataset + "/import"
	system "mkdir", "datasets/" + dataset + "/results"
	system "touch", "datasets/" + dataset + "config.json"

	Dataset.create({name: dataset})
	p "Created dataset " + dataset

	system "rails generate controller " + dataset
end