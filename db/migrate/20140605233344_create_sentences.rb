class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences, :id => false do |t|
      t.integer :sentence_id
      t.integer :dataset_id
      t.string :sentence
      t.timestamps
    end
  end
end
