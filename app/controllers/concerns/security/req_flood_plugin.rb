module Concerns
  module Security
    module ReqFloodPlugin
      include Concerns::Http::RequestPlugin

      def is_flooder(action_name,threshold, exp_time = 5.minutes)
        req_ip = remote_ip
        req =  RequestFlood.request_log(action_name,req_ip)
        # Add it If new Action / IP  is new
        if req.blank?
          req = RequestFlood.new(client_ip: req_ip,action: action_name,
                                          threshold: threshold, expiration_date: DateTime.now + exp_time )
          unless req.save
            # TODO Add a dump exception handler
          end
        else
          # Reset date + counter if request has expired.
          if  DateTime.now > req.expiration_date
            req.reset_request_log(exp_time,threshold)
          else
            # yell if user exceeds threshold, and update expiration date
            if req.attempt >= req.threshold
             return true
            end
            req.update_request_log(exp_time)
          end
        end
        false
      end
    end
  end

end
