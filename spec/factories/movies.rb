FactoryBot.define do
    factory :movie do
      name { "My first movie" }
      description {"Movie Description"}
      duration{16}
      director{"Originally"}
    end
  end