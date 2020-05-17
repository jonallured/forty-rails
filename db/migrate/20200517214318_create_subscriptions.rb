class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user

      t.string :stripe_subscription_id
      t.date :starts_on
      t.date :ends_on

      t.timestamps
    end
  end
end
