class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores, comment: '店舗' do |t|
      t.string :name, null: false, comment: '店舗名'
      t.integer :business_type, null: false, default: 0, comment: '業態'

      # 必須か微妙なのでnullableに指定
      t.text :description, comment: '店舗の雰囲気など'
      t.text :link_url, comment: '店舗のURL'

      t.timestamps
    end
  end
end
