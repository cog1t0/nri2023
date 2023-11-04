class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, comment: 'ユーザー' do |t|
      t.references :icon, null: false, foreign_key: true, comment: 'アイコンID'
      t.references :event, null: false, foreign_key: true, comment: 'イベントID'
      t.references :group, comment: 'グループID'
      t.string :name1, null: false, comment: '名前1'
      t.string :name2, null: false, comment: '名前2'
      t.text :profile, comment: 'プロフィール'
      t.string :line_id, null: false, comment: 'LINE ID'
      # 幅広い日時を選択する可能性があるため、nullableにする
      t.datetime :from, null: true, comment: '集合可能開始時間'
      t.datetime :to, null: true, comment: '集合可能終了時間'

      t.timestamps
    end
  end
end