class AddIndexesOnForeignsToSentences < ActiveRecord::Migration
  def change
  	add_index :sentences, :dataset_id
  	add_index :sentences, :sentence_id
  end
end
