class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 50
      t.string :email, limit: 255, null: false
      t.string :password, limit: 100
      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }, null: false
    end

    add_index :users, [:name, :email], name: 'user_index_1'
    add_index :users, :email, unique: true
  end
end

