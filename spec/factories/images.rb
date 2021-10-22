FactoryBot.define do
    factory :image do
      images { [ Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image1.jpg'), 'spec/fixtures/image1.jpg') ] }
      post
    end
  end