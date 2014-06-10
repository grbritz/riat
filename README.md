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

This will create a file structure under datasets/dataset_name
Place the sentences and relation instances used for that dataset in datasets/dataset_name/import
Then run (assuming ;; was used as the delimeter for importing)
rake dataset:import_model[dataset_name,Sentence,';;']
rake dataset:import_model[dataset_name,RelationInstance,';;']

You now will have the new dataset and its data ready to go. 

### Front End
A basic controller will be generated for you when you create a new dataset, but currently it does not auto generate everything you will need. Look at the UI for distant_supervision1 for an example of how to set up the front end.
