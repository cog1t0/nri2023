class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events, comment: 'イベント' do |t|
      t.string :name, null: false, comment: 'イベント名'
      t.integer :mice_type, null: false, default: 0, comment: 'MICEのタイプ'

      t.timestamps
    end
  end
end
