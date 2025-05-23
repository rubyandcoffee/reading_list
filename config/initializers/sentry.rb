# frozen_string_literal: true

Sentry.init do |config|
  # config.breadcrumbs_logger = [:active_support_logger]
  config.dsn = Rails.application.credentials.dig(:sentry_dsn)
  # config.traces_sample_rate = 1.0
  config.environment = Rails.env
  config.debug = true if Rails.env.development?
  # config.send_default_pii = true
end
