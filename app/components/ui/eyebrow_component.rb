module Ui
  class EyebrowComponent < ApplicationComponent
    TONES = {
      accent: "color: var(--color-accent);",
      dark: "color: var(--color-dark-accent);",
      muted: "color: var(--color-ink-softer);"
    }.freeze

    def initialize(tone: :accent, class: nil)
      @tone = tone
      @extra_class = binding.local_variable_get(:class)
    end

    def call
      content_tag(:div, content,
        class: [ "ps-eyebrow", @extra_class ].compact.join(" "),
        style: TONES.fetch(@tone))
    end
  end
end
