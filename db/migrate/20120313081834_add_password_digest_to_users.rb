class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :passwod_digest, :string

  end
end
