FactoryGirl.define do
  factory :user do |f|
    f.name {Faker::Name.name}
    f.email {Faker::Internet.email}
    f.password {"foobar"}
    f.password_confirmation {"foobar"}
    f.role {0}
  end

  factory :invalid_user, parent: :user do |f|
    f.name {nil}
  end

  factory :update_user, parent: :user do |f|
    f.name {"test_user"}
  end

  factory :admin_user, parent: :user do |f|
    f.role {1}
  end

  factory :category do |f|
    f.name {Faker::Name.title}
    f.description {Faker::Lorem.sentence}
  end

  factory :invalid_category, parent: :category do |f|
    f.name {nil}
  end

  factory :update_category, parent: :category do |f|
    f.name {"test_category"}
  end
end
