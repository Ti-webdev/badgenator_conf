FactoryGirl.define do
  factory :badge do
  	badge_set
    sequence(:name) { |i| "Name #{i}" }
    sequence(:surname) { |i| "Surname #{i}" }
    sequence(:company) { |i| "My company #{i}" }
    sequence(:profession) { |i| "the best profession #{i}" }
  end
end