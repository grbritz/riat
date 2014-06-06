class UpdateSentenceColSentences < ActiveRecord::Migration
  def change
  	change_column :sentences, :sentence, :text
  end
end
