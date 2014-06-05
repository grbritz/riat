#lib/tasks/csv_model_import.rake
desc "Imports a CSV file into an ActiveRecord table"
task :csv_model_import, [:filename, :model, :delim] => :environment do |task,args|
  lines = File.new(args[:filename]).readlines
  header = lines.shift.strip
  delim = (args[:delim].nil?) ? ',' : args[:delim]
  keys = header.split(delim)
  counter = 0
  # p "delim " + delim

  lines.each do |line|
    values = line.strip.split(delim)
    counter += 1
    attributes = Hash[keys.zip values]
    # p attributes

    args[:model].constantize.create(attributes)

  end
end