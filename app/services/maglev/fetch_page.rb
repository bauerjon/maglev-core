module Maglev
  # Retrieve a page from a path and a locale
  # (previously extracted by the ExtractLocale service)
  class FetchPage
    include Injectable

    argument :path
    argument :locale
    argument :default_locale
    argument :fallback_to_default_locale, default: false
    argument :site_id

    def call
      page = fetch_page(path, locale)
      page = fetch_page(path, default_locale) if !page && fallback_to_default_locale
      page
    end

    protected

    def fetch_page(path, locale)
      Maglev::Page.where(site_id: site_id).by_path(path || 'index', locale).first
    end
  end
end