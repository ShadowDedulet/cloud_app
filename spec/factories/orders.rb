FactoryBot.define do
  factory :order do
    sequence(:name) { |n| "order_#{n}" }
  end
end
