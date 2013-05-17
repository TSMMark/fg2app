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
    # one to many
    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:authentication, 1, user: user)
    end
  end

  factory :authentication do
    user
    provider  "facebook"
    uid       "1294176482"
    token     "CAAFdElh3jpMBAHIfJ8ZBvs6UyMGIvI9mEmpSVQN3ulZBAQsbqmsPhm5vdj3Jjtujxq35TJY7lUVT4waxWNzvGfdx5y3ip8ksYVgLg2oDgiqQH3OsG26UOpzTFw6QzXDberhcZCNuDZAm1n0aVwShLPo9yuoQAicZD"
  end

end
