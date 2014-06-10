class ChangeIsGoodToIsBadOnAnnotations < ActiveRecord::Migration
  def change
  		rename_column :annotations, :is_good_pattern, :is_bad_pattern
  end
end
