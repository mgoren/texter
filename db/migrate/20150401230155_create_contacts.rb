class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :name, default: ""
      t.string :phone
    end
    add_column :messages, :contact_id, :integer
  end
end
