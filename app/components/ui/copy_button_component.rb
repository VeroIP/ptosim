module Ui
  # Copy-to-clipboard button. Backed by the `clipboard` Stimulus controller.
  #
  # Variants:
  #   :labeled — icon + text ("Copy" → "Copied")
  #   :icon    — icon-only; the label is still set as aria-label for a11y
  #
  # Sizes: :sm, :md
  class CopyButtonComponent < ApplicationComponent
    VARIANTS = %i[labeled icon].freeze
    SIZES    = %i[sm md].freeze

    def initialize(value:, label: "Copy", copied_label: "Copied", variant: :labeled, size: :sm)
      raise ArgumentError, "unknown variant: #{variant}" unless VARIANTS.include?(variant)
      raise ArgumentError, "unknown size: #{size}"       unless SIZES.include?(size)

      @value = value
      @label = label
      @copied_label = copied_label
      @variant = variant
      @size = size
    end

    def classes
      base = [ "ps-copy-btn", "ps-copy-btn-#{@size}" ]
      base << "ps-copy-btn-icon" if @variant == :icon
      base.join(" ")
    end
  end
end
