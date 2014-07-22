class RequestFlood   < ActiveRecord::Base
   self.table_name = 'request_flood'
   def self.request_log(action_name,remote_ip)
    self.where(:client_ip => remote_ip,:action => action_name)
    .select(:id,:action,:threshold,:expiration_date,:attempt,:threshold).first
   end

  def reset_request_log(exp_time,threshold)
    update_attributes(:attempt => 1,:expiration_date => DateTime.now + exp_time,:threshold => threshold)
  end

  def update_request_log(exp_time)
   update_attributes(:attempt => 1+attempt,:expiration_date => DateTime.now + exp_time)
  end

end