class AddIndexToDatasets < ActiveRecord::Migration
  def change
    add_index :datasets, :name, unique: true
  end
end
