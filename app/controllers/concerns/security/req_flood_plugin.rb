module Concerns
  module Security
    module ReqFloodPlugin
      include Concerns::Http::RequestPlugin
      def update_flooder(action_name,exp_time = 5.minutes,threshold = 4)
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
          if  DateTime.now > req.expiration_date
            req.reset_request_log(exp_time,threshold)
          else
            req.update_request_log(exp_time)
          end
        end
      end
      def is_flooder(action_name)
        req_ip = remote_ip
        req =  RequestFlood.request_log(action_name,req_ip)
        if req.blank?
           false
        else
          if DateTime.now > req.expiration_date
            return false
          end
          if  req.attempt >= req.threshold
            return true
          end
        end
      end

      def check_flooder
        if is_flooder(action_name)
          respond_to do |format|
            format.json { render  json: { :result => 0,:info => t('security.flooder_detection')},status: 422  }
          end
        else
          update_flooder(action_name)
        end
      end
    end
  end

end
