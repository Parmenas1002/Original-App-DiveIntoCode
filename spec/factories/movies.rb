FactoryBot.define do
    factory :movie do
      name { "My first movie" }
      description {"Movie Description"}
      user_id {1}
      category_id{1}
    end
  end