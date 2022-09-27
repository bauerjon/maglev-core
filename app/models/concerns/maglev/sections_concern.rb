# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
module Maglev::SectionsConcern
  def prepare_sections
    # NOTE: pages defined in the theme definition
    # don't include the ids for sections/blocks
    self.sections ||= [] # NOTE: the self is mandatory here
    sections.each do |section|
      prepare_section(section)
    end
  end

  private

  def prepare_section(section)
    section['id'] ||= SecureRandom.urlsafe_base64(8)
    section['settings'] = prepare_settings(section['settings'])
    (section['blocks'] || []).each do |block|
      block['id'] ||= SecureRandom.urlsafe_base64(8)
      block['settings'] = prepare_settings(block['settings'])
    end
    section
  end

  def prepare_settings(settings)
    # NOTE: in the theme definition file, we allow developers to declare
    # default content like this: { <setting_id_1>: <setting_value_1>, ..., <setting_id_n>: <setting_value_n> }
    return settings if settings.is_a?(Array)

    settings.map { |key, value| { id: key, value: value } }
  end
end
# rubocop:enable Style/ClassAndModuleChildren