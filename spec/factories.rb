FactoryGirl.define do 

  factory :user do
    sequence(:email){ |n| "user_numero_#{ n }@mail.com" }
    password 'all_users_have_same_password'
  end

  factory :post do
    sequence(:name){ |n| "post_numero_#{ n }" }
    text 'Post text'
    user
  end
  
  factory :comment do
    text 'Post text'
    user
  end

  factory :role do
    title 'test'
    user
  end
end
