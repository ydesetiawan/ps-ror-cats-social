class CreateCats < ActiveRecord::Migration[7.1]
  def change
    create_table :cats do |t|
      t.references :user, null: false, foreign_key: true, type: :bigint
      t.string :name, null: false, limit: 30
      t.string :race, null: false
      t.string :sex, null: false
      t.integer :age_in_months, null: false
      t.text :image_urls, array: true, default: []
      t.string :description, null: false, limit: 200
      t.boolean :has_matched, null: false, default: false

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_index :cats, :name
  end
end
