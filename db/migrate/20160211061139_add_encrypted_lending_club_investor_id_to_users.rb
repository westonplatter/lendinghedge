class AddEncryptedLendingClubInvestorIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_lending_club_investor_id, :string
  end
end
