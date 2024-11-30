class AddContentAndRoomIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :content, :string unless column_exists?(:messages, :content)
  end
end
