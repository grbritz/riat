#Relation Instance Annotation Tool - RIAT
RIAT uses humans to annotate relational instances for the purposes of evaluating and training relation information extraction systems.

### Setup
Clone the repo and run the following commands to get setup:
    rake db:create
    rake db:migrate
    rake dataset:import_existing

The first two commands will setup the database and schema. The last will import any existing datasets into the database with the sentences and relation instances used with them. It will not import annotations from previous experiments.

### New dataset
To get started with a new dataset, run:

    rake dataset:new[dataset_name]

This will create a file structure under `datasets/dataset_name`
Place the sentences and relation instances used for that dataset in `datasets/dataset_name/import
Then run (assuming ;; was used as the delimeter for importing)

    rake dataset:import_model[dataset_name,Sentence,';;']
    rake dataset:import_model[dataset_name,RelationInstance,';;']

You now will have the new dataset and its data ready to go. 

### Front End
When you create a new dataset, a controller skeleton will be generated for you. As this time, the generator does not automate much, but rather gives you a starting point for writing your own controllers. Tutorials and an annotation interface have been made for the distant_supervision1. You can use those as a starting point when running other distant supervision experiments. Common code related to user progress and displaying data is found in `base_helper`, and you should include that in your helper file for a new dataset.


### Exporting from remote
After running an experiment, you'll likely want to pull the data down for analysis or so that you can export it to another tool. Run the following commands to do this (note, will drop all data on your local setup)
    
    rake db:drop
    PGUSER=`localuser` PGPASSWORD=`localpassword` heroku pg:pull `riat_production` `localdbname` --app `herokuappname`

