class AddAvatarColumnToContactsAndUsers < ActiveRecord::Migration
  def change
    add_attachment :contacts, :avatar
    add_attachment :users, :avatar
  end
end
