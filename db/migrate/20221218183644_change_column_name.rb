class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :Beers, :style, :old_style
  end
end
