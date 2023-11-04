class CreateIcons < ActiveRecord::Migration[7.0]
  def change
    create_table :icons, comment: 'アイコン' do |t|
      t.text :image_url, null: false, comment: 'アイコンのURL'

      t.timestamps
    end
  end
end