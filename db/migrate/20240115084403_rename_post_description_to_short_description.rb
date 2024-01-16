class RenamePostDescriptionToShortDescription < ActiveRecord::Migration[7.1]
  def change
    rename_column(:posts, :description, :short_description)
  end
end
