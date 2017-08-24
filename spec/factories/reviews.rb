FactoryGirl.define do
  factory :review do
    rating 3
    body 'this restaurant was definitely a restaurant. if you want a restaurant, this is certainly that.'
    user
    restaurant
  end
end
