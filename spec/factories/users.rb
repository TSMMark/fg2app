# This will guess the User class
# User.delete_all

FactoryGirl.define do
  sequence(:name) { |n| "Example Name #{n}" }
  sequence(:email) { |n| "foo#{n}@example.com" }
  
  factory :user do
    name
    email
    password  "foobar123"
    password_confirmation { "#{password}" }
  end

  factory :user_with_auth, parent: :user do
    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:authentication, 1, user: user)
    end
    #authentications { [create(:authentication)] }
  end

  factory :authentication do
    association :user, factory: :user
    provider  "facebook"
    uid       "1294176482"
    token     "CAAFdElh3jpMBAE5MZCsrCCTn7yTFZAhlykvot6FcNPRzd9aHLZBzRiulcA15U2TWq5UK8DAcelYxOl8ZABCIkojQRl9MUoz2OyZCwn9ZAaMcNzy3MjpqZBSfvZBSueIiNv4bxYqwYiF6D2vqMYfSSknTSRdAYF1fmowZD"
  end

end
