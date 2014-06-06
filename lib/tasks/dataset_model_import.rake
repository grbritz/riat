#lib/tasks/csv_model_import.rake
desc "Imports a model using a delimited (eg comma seperated, tab seperated, etc) file for a dataset."
task :dataset_model_import, [:model, :dataset, :delim] => :environment do |task,args|
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
    attributes.update({dataset_id: datasetId})
    
    args[:model].constantize.create(attributes)
  end
end