class AddColumnToSentences < ActiveRecord::Migration
  def change
    add_column :sentences, :dataset_sentence_id, :integer
  end
end
