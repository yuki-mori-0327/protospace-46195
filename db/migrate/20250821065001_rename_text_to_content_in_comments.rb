class RenameTextToContentInComments < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :text, :content
  end
end
