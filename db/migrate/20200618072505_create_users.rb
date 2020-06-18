class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
#nameカラムはユニークである必要がある為、uniqueキー制約を設定する
    add_index :users, :name, unique: true
  end
end
