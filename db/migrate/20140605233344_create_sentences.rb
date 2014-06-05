class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.integer :dataset_id
      t.string :sentence

      t.timestamps
    end
  end
end
