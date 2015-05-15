class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.string :email
      t.string :amount
      t.string :term
      t.string :payment
      t.string :status

      t.timestamps null: false
    end
  end
end
