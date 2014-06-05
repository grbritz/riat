class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.integer :relation_instance_id
      t.integer :user_id
      t.integer :annotation
      t.boolean :is_good_pattern
      t.text :ambiguity_reason

      t.timestamps
    end
  end
end
