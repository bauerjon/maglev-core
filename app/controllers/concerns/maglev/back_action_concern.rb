# frozen_string_literal: true

module Maglev
  module BackActionConcern
    private

    def call_back_action
      case maglev_config.back_action
      when nil
        redirect_to default_leave_url
      when String
        redirect_to maglev_config.back_action
      when Symbol
        redirect_to main_app.send(maglev_config.back_action)
      when Proc
        instance_exec(maglev_site, &maglev_config.back_action)
      end
    end

    def default_leave_url
      main_app.root_path
    rescue StandardError
      '/'
    end
  end
end
