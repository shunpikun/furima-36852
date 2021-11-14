class RenamePrefectureColumnToAddresses < ActiveRecord::Migration[6.0]
  def change
    rename_column :addresses, :prefecture, :prefecture_id
  end
end
