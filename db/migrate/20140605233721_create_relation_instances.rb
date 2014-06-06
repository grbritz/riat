class CreateRelationInstances < ActiveRecord::Migration
  def change
    create_table :relation_instances do |t|
      t.integer :dataset_id
      t.integer :sentence_id
      t.string :mid1, limit:10
      t.integer :extent1_begin
      t.integer :extent1_end
      t.string :extent1_text, limit:200
      t.string :mid2, limit:10
      t.integer :extent2_begin
      t.integer :extent2_end
      t.string :extent2_text, limit:200
      t.string :relation, limit:200

      t.timestamps
    end
  end
end
