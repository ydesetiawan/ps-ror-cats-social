class CreateCatMatches < ActiveRecord::Migration[7.1]
  def change
    execute <<-SQL
      CREATE TYPE status_match_enum AS ENUM ('pending', 'approved', 'rejected');
    SQL
    create_table :cat_matches do |t|
      t.references :issuer, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.bigint :match_cat_id, null: false
      t.bigint :user_cat_id, null: false
      t.string :message, limit: 120, null: false
      t.column :status, :status_match_enum, null: false
      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
    add_index :cat_matches, [:user_cat_id, :match_cat_id, :status], name: 'idx_cat_matches_all_columns'
  end
end
