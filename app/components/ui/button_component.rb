module Ui
  class ButtonComponent < ApplicationComponent
    VARIANTS = {
      primary: "ps-btn-primary",
      ghost: "ps-btn-ghost",
      invert: "ps-btn-invert",
      dark_ghost: "ps-btn-dark-ghost"
    }.freeze

    SIZES = { md: "ps-btn-md", sm: "ps-btn-sm" }.freeze

    def initialize(href: "#", variant: :primary, size: :md, class: nil)
      @href = href
      @variant = variant
      @size = size
      @extra_class = binding.local_variable_get(:class)
    end

    def classes
      [ "ps-btn", VARIANTS.fetch(@variant), SIZES.fetch(@size), @extra_class ].compact.join(" ")
    end

    def call
      link_to(content, @href, class: classes)
    end
  end
end
