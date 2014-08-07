  class SlapMobileLogin < ActiveRecord::Base
    include ValidationFields


    self.table_name = 'slap_users'
    @@lock = Mutex.new
    validates :email, :presence => true, :format => EMAIL_REGEX,:length => { :maximum => 50 }
    validates :password,:presence => true,:length => { :in => 6..20 }
    validates :inst_id,:presence => true


    def self.find_user_by_email(email)
      if ValidationFields.email_valid(email)
        find_by(email: email.downcase)
      end
    end

    def build_response
      mobile_token =  SecureRandom.uuid + SecureRandom.hex(16)
        SlapMobileLogin.where(:email => email)
        .update_all(:mobile_token => mobile_token, :inst_id => inst_id)
        [:email => email,:username => username,:mobile_token => mobile_token,
         :first_name => first_name,
         :last_name => last_name
          ].join.as_json

    end
    def compare_passwords(pass)
      password == ValidationFields.encrypt_password(pass)
    end

  end
