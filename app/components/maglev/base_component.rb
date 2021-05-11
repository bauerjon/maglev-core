# frozen_string_literal: true

module Maglev
  class BaseComponent
    extend Forwardable
    def_delegators :view_context, :render

    attr_accessor :view_context

    def build(component_class, attributes)
      component_class.new(**attributes).tap do |component|
        component.view_context = view_context
      end
    end

    # Useful helper to avoid manipulating hashes
    # eg.: <%= section.settings.body %> instead of <%= section.settings[:body] %>
    def settings_proxy(map)
      settings_keys = map.keys
      return nil if settings_keys.blank?

      settings_struct = Struct.new(*settings_keys)
      settings_struct.new(*map.values)
    end

    def build_settings_map(settings)
      definition.settings.inject({}) do |memo, setting|
        memo.merge(
          setting.id.to_sym => build_content(
            self,
            settings[setting.id.to_sym],
            setting
          )
        )
      end
    end

    def build_content(scope, content, setting)
      Maglev::Content::Builder.build(scope, content, setting)
    end
  end
end