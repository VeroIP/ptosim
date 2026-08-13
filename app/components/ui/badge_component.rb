module Ui
  class BadgeComponent < ApplicationComponent
    def initialize(label:)
      @label = label
    end

    def call
      content_tag(:span, @label,
        class: "ps-mono",
        style: "font-size:9.5px;letter-spacing:0.14em;text-transform:uppercase;color:var(--color-ink-softer);" \
               "border:1px solid oklch(0.22 0.015 250 / 0.16);padding:3px 6px;border-radius:var(--radius-sm);")
    end
  end
end
