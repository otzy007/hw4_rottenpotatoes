FactoryGirl.define do
  factory :movie do
    title 'Title'
    rating 'R'
    release_date { 2.years.ago }
    director 'me :)'
  end
end
