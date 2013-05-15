# This will guess the User class
#User.delete_all
FactoryGirl.define do
  factory :user do
    name      "John"
    email     "foo@example.com"
    password  "foobar123"
    password_confirmation { "#{password}" }
  end
end