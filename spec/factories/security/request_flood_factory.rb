FactoryGirl.define do
  factory :request_flood, :class => RequestFlood do
    client_ip "123.45.67.89"
    expiration_date DateTime.now + 5.minutes
    action "login"
    attempt 4
    threshold 4
  end

end
