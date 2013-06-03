# This will guess the User class
# User.delete_all

FactoryGirl.define do
  sequence(:name) { |n| "Example Name #{n}" }
  sequence(:email) { |n| "foo#{n}@example.com" }
  sequence(:description) { |n| "this is the #{n}th description" }
  sequence(:category) { |n| "this is the #{n}th category" }
  sequence(:page) { |n| FactoryGirl.create(:page) }
  sequence(:fbapp) { |n| FactoryGirl.create(:fbapp) }
  
  # users
  factory :user do
    name
    email
    password  "foobar123"
    password_confirmation { "#{password}" }
    guest false
  end

  factory :user_with_auth, parent: :user do
    # one to many
    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:authentication, 1, user: user)
    end
  end

  factory :user_default, parent: :user_with_auth do
    # the default user factory used everywhere
  end

  factory :admin, parent: :user_default do
    admin true
    # the default user factory used everywhere
  end

  factory :guest, parent: :user_default do
    guest true
    # the default user factory used everywhere
  end


  # authentications
  factory :authentication do
    user
    provider  "facebook"
    uid       "1294176482"  # mark allen facebook
    token     "CAAFdElh3jpMBAHIfJ8ZBvs6UyMGIvI9mEmpSVQN3ulZBAQsbqmsPhm5vdj3Jjtujxq35TJY7lUVT4waxWNzvGfdx5y3ip8ksYVgLg2oDgiqQH3OsG26UOpzTFw6QzXDberhcZCNuDZAm1n0aVwShLPo9yuoQAicZD"
  end
  
  # pagetokens
  factory :pagetoken do
    user
    page
    token     "CAAFdElh3jpMBAHIfJ8ZBvs6UyMGIvI9mEmpSVQN3ulZBAQsbqmsPhm5vdj3Jjtujxq35TJY7lUVT4waxWNzvGfdx5y3ip8ksYVgLg2oDgiqQH3OsG26UOpzTFw6QzXDberhcZCNuDZAm1n0aVwShLPo9yuoQAicZD"
    perms     '["PERMS"]'
  end
  
  # pages
  factory :page do
    name
    pid         "1738145289657422"  # fangate mosaic page
    category

    ignore do
      page_count Random.new.rand(2..5)  # the number pages that should be in the list
    end

    after(:build) do |page, evaluator|
      evaluator.page_count.times do
        #user = FactoryGirl.create(:user_default, email: FactoryGirl.generate(:email))
        FactoryGirl.create(:pagetoken, {
          page: page,
          user: user = FactoryGirl.create(:user_default)
        })
      end
    end
  end

  factory :fbapp do
    namespace "myfangate_i"
    key       "129418400529051"
    secret    "f122af8f63887e22d7be61baed878974"
  end

  # tab with parent pages
  factory :tab do
    page
    fbapp
    name
    description
  end

end
