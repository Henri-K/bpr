class AddThumbupAndThumbdownToShowings < ActiveRecord::Migration
  def change
    add_column :showings, :thumbup, :boolean
    add_column :showings, :thumbdown, :boolean
  end
end
