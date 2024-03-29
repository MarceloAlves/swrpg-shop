# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Importing Sources'
source_books = JSON.parse(File.read(Rails.root.join('db', 'seed_data', 'source_books.json')))
SourceBook.create(source_books.fetch('source_books'))

puts 'Importing Armor'
armor = JSON.parse(File.read(Rails.root.join('db', 'seed_data', 'armor.json')))
Armor.create(armor)

puts 'Importing Gear'
gear = JSON.parse(File.read(Rails.root.join('db', 'seed_data', 'gear.json')))
Gear.create(gear)

puts 'Importing Item Attachments'
ia = JSON.parse(File.read(Rails.root.join('db', 'seed_data', 'item_attachments.json')))
ItemAttachment.create(ia)

puts 'Importing Weapons'
weapons = JSON.parse(File.read(Rails.root.join('db', 'seed_data', 'weapons.json')))
Weapon.create(weapons)

puts 'Importing Specialized Shops'
shops = JSON.parse(File.read(Rails.root.join('db', 'seed_data', 'shops.json')))
SpecializedShop.create(shops)

puts 'Creating Worlds'
worlds = JSON.parse(File.read(Rails.root.join('db', 'seed_data', 'worlds.json')))
World.create(worlds)
