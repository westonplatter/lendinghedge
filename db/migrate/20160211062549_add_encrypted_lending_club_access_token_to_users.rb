class AddEncryptedLendingClubAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_lending_club_access_token, :string
  end
end
