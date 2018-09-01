FactoryBot.define do
  factory :expert do
    sequence(:name)       { |n| "Jane Expert#{n}" }
    url {"https://en.wikipedia.org/wiki/Dog_training"}
  end
end
