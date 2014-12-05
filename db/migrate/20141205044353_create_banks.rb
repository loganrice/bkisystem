class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.string :aba
      t.string :swift
      t.string :attention

      t.timestamps
    end
  end
end
