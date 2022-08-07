class AddSubscriptionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :plan, :string
    add_column :users, :subscription_status, :string, default: "incomplete"
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
