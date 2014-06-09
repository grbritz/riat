class CreateUserSentenceCompleted < ActiveRecord::Migration
  def change
    create_table :user_sentence_completed, id: false do |t|
    	t.integer :user_id
    	t.integer :sentence_id
    	t.integer :dataset_id

    	t.index :user_id
    	t.index :sentence_id
    	t.index :dataset_id
    end
  end
end
