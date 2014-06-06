#lib/tasks/new_dataset

desc ""
task :new_dataset, [:name] => :environment do |task, args|
	dataset = args[:name].underscore
	system "mkdir", "datasets/" + dataset
	system "mkdir", "datasets/" + dataset + "/config"
	system "mkdir", "datasets/" + dataset + "/import"
	system "mkdir", "datasets/" + dataset + "/results"

	Dataset.create({name: dataset})

	p "Created dataset " + dataset
end