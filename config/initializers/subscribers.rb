module ActionController
  class PageRequest
   def call(name, started, finished, unique_id, payload)
     Rails.logger.debug ["active_job notification:", name, started, finished, unique_id, payload].join(" ")
   end
  end
end

ActiveSupport::Notifications.subscribe /active_job/, ActionController::PageRequest.new
