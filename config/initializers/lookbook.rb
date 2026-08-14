return unless Rails.env.development? && defined?(Lookbook)

Rails.application.config.lookbook.project_name = "PTO Sim Design System"
Rails.application.config.lookbook.ui_theme = "zinc"
Rails.application.config.lookbook.preview_paths = [ Rails.root.join("test/components/previews") ]
Rails.application.config.lookbook.preview_display_options = {
  theme: %w[light dark]
}
