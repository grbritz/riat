class CreateRelationInstances < ActiveRecord::Migration
  def change
    create_table :relation_instances do |t|
      t.integer :dataset_id
      t.integer :sentence_id
      t.string,10 :mid1
      t.integer :extent1_begin
      t.integer :extent1_end
      t.string,200 :extent1_text
      t.string,10 :mid2
      t.integer :extent2_begin
      t.integer :extent2_end
      t.string,200 :extent2_text
      t.string,200 :relation

      t.timestamps
    end
  end
end
