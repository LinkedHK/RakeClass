include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user_images do  |image|
    #  file ActionDispatch::Http::UploadedFile.new(:tempfile => File.new(Rails.root + 'spec/factories/images/default.png'), :filename => "default.png")
    #image.avatar { fixture_file_upload(Rails.root.join('spec', 'factories','images', 'default.png'), 'image/png') }
    image.avatar  File.new(Rails.root.join('spec', 'fixtures','images', 'default.png'))
    #image.avatar  File.new(Rails.root + 'spec/factories/images/default.png')
    factory :profile_image do |img|
      img.avatar  File.new(Rails.root.join('spec', 'fixtures','images', 'default.png'))
      img.profile_image 1
      association :imageable, factory: :slap_user
    end
  end


end
