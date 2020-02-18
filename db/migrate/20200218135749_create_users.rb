class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.string :password_digest
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
