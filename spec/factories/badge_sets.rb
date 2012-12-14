require 'faker'

FactoryGirl.define do
  factory :badge_set do
    sequence(:name) { |i| "Badge set #{i}" }
    
    trait :source do
      source Rack::Test::UploadedFile.new('spec/fixtures/badges.csv', 'text/plain')
    end
    
    trait :image do
      image Rack::Test::UploadedFile.new('spec/fixtures/logo.png', 'image/png')
    end
    
    factory :badge_set_with_badges do
      ignore do
        badges_count 5
      end

      after(:create) do |badge_set, evaluator|
        FactoryGirl.create_list(:badge, evaluator.badges_count, badge_set: badge_set)
      end
    end 
  end
end