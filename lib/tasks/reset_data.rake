task reset_data: :environment do
  puts 'Destroying Data'
  Armor.delete_all
  Gear.delete_all
  ItemAttachment.delete_all
  Weapon.delete_all
  SpecializedShop.delete_all

  puts 'Reset Primary Key'
  %w[armors gears item_attachments weapons specialized_shops].each do |table_name|
    ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
  end

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

  puts 'Done'
end
