User.create(name: 'administrator', email: 'admin@admin.com', password: 'password', password_confirmation: 'password')
Admin.create(user_id: 1)

200.times do
  User.create(
    name:                   Faker::Name.name,
    email:                  Faker::Internet.email,
    phone:                  Faker::PhoneNumber.phone_number,
    password:               'password',
    password_confirmation:  'password'
  )
  Organization.create(
    name:         Faker::Company.name,
    description:  Faker::Lorem.paragraph(2),
    current:      true,
    address:      Faker::Address.street_address,
    city:         Faker::Address.city,
    province:     Faker::Address.state_abbr,
    postal:       Faker::Address.zip
  )
end

Supply.create(name: 'Desk', maximum: 100)
Supply.create(name: 'Keys', maximum: 50)
Supply.create(name: 'Lockers', maximum: 50)

100.times do
  list_user = SupplyList.new(supply_id: rand(1..3),user_id: rand(1..200), name: rand(100..900))
  list_user.save if list_user.valid?

  list_org = SupplyList.new(supply_id: rand(1..3), organization_id: rand(1..200), name: rand(100..900))
  list_org.save if list_org.valid?

  org_member = OrganizationMember.new(organization_id: rand(1..200), user_id: rand(1..200))
  org_member.save if org_member.valid?
end