class AddEncryptedLendingClubApiKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_lending_club_api_key, :string
  end
end
