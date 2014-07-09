FactoryGirl.define do
  factory :user_images do |image|
    image.avatar  File.new(Rails.root + 'spec/factories/images/default.png')
    profile_image 1
    image.imageable { |a| a.association(:slap_user)}
  end
end