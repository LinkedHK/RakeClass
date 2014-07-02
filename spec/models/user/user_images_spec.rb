#require 'rails_helper'
describe User::UserImages do
  context  'Basic validation of uploaded images' do
    it 'Expect to have an attached file' do
      expect have_attached_file(:avatar)
    end
    it 'Validate Attachment presence' do
      expect validate_attachment_presence(:avatar)
    end
    it 'validate attachment content' do
      expect validate_attachment_content_type(:avatar)
          .allowing('image/png', 'image/gif','image/jpeg')
          .rejecting('text/plain', 'text/xml')
    end
    it 'validate attachment size' do
      expect validate_attachment_size(:avatar)
      .less_than(5.megabytes)
    end
  end

end