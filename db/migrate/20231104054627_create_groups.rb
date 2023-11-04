class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups, comment: 'グループ' do |t|
      t.string :team_name, null: false, comment: 'チーム名'
      # TODO: 位置情報のカラムを追加

      t.timestamps
    end
  end
end
