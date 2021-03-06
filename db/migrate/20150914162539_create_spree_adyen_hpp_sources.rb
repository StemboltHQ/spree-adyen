# Fields come from
# https://docs.adyen.com/display/TD/HPP+payment+response
class CreateSpreeAdyenHppSources < ActiveRecord::Migration
  def change
    create_table :spree_adyen_hpp_sources do |t|
      t.string :auth_result
      t.string :psp_reference
      t.string :merchant_reference
      t.string :skin_code
      t.string :merchant_sig
      t.string :payment_method
      t.string :shopper_locale
      t.string :merchant_return_data

      t.timestamps
    end

    add_index :spree_adyen_hpp_sources, :psp_reference, unique: true

    if Rails.version >= "4.2"
      add_foreign_key :spree_adyen_hpp_sources,
        :spree_orders,
        column: :merchant_reference,
        primary_key: :number
    else
      # order_id doesn't appear to have a uniqueness constraint.
      add_index :spree_adyen_hpp_sources, :merchant_reference
    end
  end
end
