class CreateSuggests < ActiveRecord::Migration[7.0]
  def change
    create_table :suggests do |t|
      t.references :group, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
