FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    encrypted_password nil
    password 'password'
    confirmation_sent_at Time.now
    confirmation_token Faker::Internet.password
    confirmed_at Time.now - 2.minutes
    remember_created_at nil
    reset_password_sent_at nil
    reset_password_token nil
    unconfirmed_email nil
    created_at Time.now
    updated_at Time.now

    trait :with_images do
      after(:create) do
        user.attach(
          io: File.open(Rails.root.join('spec', 'factories', 'images', 'soy.jpeg')),
          filename: 'soy.jpeg',
          content_type: 'image/jpeg'
        )
      end
    end
  end
end
