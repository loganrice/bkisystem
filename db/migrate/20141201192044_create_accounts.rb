class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :phone1
      t.string :phone2
      t.string :fax
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address_1_line_1
      t.string :address_1_line_2
      t.string :address_1_line_3
      t.string :address_1_city
      t.string :address_1_state
      t.string :address_1_zip
      t.string :address_1_country
      t.text :notes
      t.string :bank_1_name
      t.string :bank_1_aba
      t.string :bank_1_account
      t.string :bank_1_swift_code
      t.string :bank_1_attention
    end
  end
end
