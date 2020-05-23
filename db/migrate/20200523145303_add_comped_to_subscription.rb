class AddCompedToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :comped, :boolean, default: false
  end
end
