# frozen_string_literal: true
FactoryBot.define do
  factory :excavator do
    ticket
    company_name { Faker::Company.name }
    address do
      {
        street:  Faker::Address.street_address,
        city:    Faker::Address.city,
        state:   Faker::Address.state,
        zip:     Faker::Address.zip_code,
        contact: {
          name:  Faker::Name.name,
          phone: Faker::PhoneNumber.phone_number,
          email: Faker::Internet.email
        },
        field_ontact: {
          name:  Faker::Name.name,
          phone: Faker::PhoneNumber.phone_number,
          email: Faker::Internet.email
        }
      }
    end
    crew_on_site { true }
  end
end


