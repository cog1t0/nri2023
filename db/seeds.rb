# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

event = Event.create!(
  name: "テストイベント",
  mice_type: 1
)
icon = Icon.create!(
  image_url: 'URL'
)

30.times do |n|
  User.create!(
    icon_id: icon.id,
    event_id: event.id,
    group_id: nil,
    name1: "名前#{n}",
    name2: "なまえ#{n}",
    line_id: SecureRandom.alphanumeric(),
    profile: ""
  );
end

Event.create!(
  name: "NRIハッカソン2023",
  mice_type: 3
);