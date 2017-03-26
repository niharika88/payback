FactoryGirl.define do
  factory :user do
    email "John@gmail.com"
    id  9
    roles_mask 1
    password "bfhvfb"
  end
end

FactoryGirl.define do
  factory :transaction do
   id  1
   transaction_description " My first ever expense" 
   amount_spent  500 
   transaction_type "home expense" 
  end
end