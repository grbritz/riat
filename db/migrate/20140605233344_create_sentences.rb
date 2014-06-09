class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences, id: false do |t|
      t.integer :sentence_id
      t.integer :dataset_id
      t.text :sentence
      t.index :dataset_id
  	  t.index :sentence_id
    end
  end
end
