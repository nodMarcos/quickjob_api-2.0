require 'faker'

services = {
  "Cleaning" => ["House Cleaning", "Office Cleaning"],
  "Plumbing" => ["Pipe Repair", "Pipe Replacement"],
  "Electrical" => ["Wiring", "Circuit Repair"],
  "Carpentry" => ["Furniture Assembly", "Cabinet Installation"],
  "Painting" => ["Interior Painting", "Exterior Painting"],
  "Landscaping" => ["Lawn Mowing", "Tree Trimming"],
  "Handyman" => ["General Repairs", "Furniture Repair"],
  "Pest Control" => ["Rodent Control", "Insect Control"],
  "Moving" => ["Local Moving", "Long Distance Moving"]
}

service_categories = services.keys
service_categories.each do |service_category_name|
  ServiceCategory.find_or_create_by!(name: service_category_name)
end

categories = ServiceCategory.where(name: service_categories).index_by(&:name)

services.each do |category_name, service_names|
  category = categories[category_name]
  service_names.each do |service_name|
    Service.find_or_create_by!(name: service_name, service_category: category)
  end
end

20.times do 
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create!(
    email: "#{first_name}.#{last_name}@gmail.com",
    first_name:,
    last_name:,
    password: '123123',
    password_confirmation: '123123'
  )
end
