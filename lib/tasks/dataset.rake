#lib/tasks/csv_model_import.rake
namespace :dataset do
  desc "Imports a model using a delimited (eg comma seperated, tab seperated, etc) file for a dataset."
  task :import_model, [:dataset, :model, :delim] => :environment do |task,args|
    dataset = args[:dataset].underscore
    path = Rails.root.join("datasets", dataset, "import").to_s
    lines = File.new(path + "/" + args[:model].pluralize.underscore + ".csv").readlines
    header = lines.shift.strip
    delim = (args[:delim].nil?) ? ',' : args[:delim]
    keys = header.split(delim)
    datasetId = Dataset.where({name: dataset}).take.id 
    

    lines.each do |line|
      values = line.strip.split(delim)
      attributes = Hash[keys.zip values]
      # Add in additional col,val for dataset_id mapping
      attributes.update({dataset_id: datasetId})
      
      args[:model].constantize.create(attributes)
    end
  end

  desc "Creates local file structure for a new dataset; Generates default controller for an experiment with that dataset"
  task :new, [:name] => :environment do |task, args|
    dataset = args[:name].underscore
    system "mkdir", "datasets/" + dataset
    system "mkdir", "datasets/" + dataset + "/import"
    system "mkdir", "datasets/" + dataset + "/results"
    system "touch", "datasets/" + dataset + "config.json"

    Dataset.create({name: dataset})
    p "Created dataset " + dataset

    system "rails generate controller " + dataset
  end

  desc "Imports existing datasets in the filesystem"
  task :import_existing => :environment do |task, args|
    datasets = Dir.glob(Rails.root.join("datasets", "*").to_s)
    datasets.each do |dataset_path|
      dataset = File.basename(dataset_path)
      Dataset.create({name: dataset})
      system "rake", "dataset:import_model[#{dataset},Sentence,;;]"
    end

  end
end

