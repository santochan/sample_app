class RenamePasswodDigestToPasswordDigestInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :passwod_digest, :password_digest
  end

  def down
    rename_colum :users,:password_digest,:passwod_digest
  end
end
