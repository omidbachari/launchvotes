class AddDefaultGravatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_gravatar, :boolean, default: true
  end
end
