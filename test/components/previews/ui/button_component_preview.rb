module Ui
  # @label Button
  # @display background_color "var(--color-bg)"
  class ButtonComponentPreview < Lookbook::Preview
    # @display background_color "var(--color-bg)"
    def primary
      render Ui::ButtonComponent.new(variant: :primary).with_content("Book a demo")
    end

    # @display background_color "var(--color-bg)"
    def ghost
      render Ui::ButtonComponent.new(variant: :ghost).with_content("See a simulation")
    end

    # Invert variant is intended for dark surfaces.
    # @display background_color "oklch(0.24 0.025 255)"
    def invert
      render Ui::ButtonComponent.new(variant: :invert).with_content("Book a demo")
    end

    # Ghost variant tuned for dark surfaces.
    # @display background_color "oklch(0.24 0.025 255)"
    def dark_ghost
      render Ui::ButtonComponent.new(variant: :dark_ghost).with_content("See a simulation")
    end

    def small
      render Ui::ButtonComponent.new(variant: :primary, size: :sm).with_content("Book a demo")
    end

    def medium
      render Ui::ButtonComponent.new(variant: :primary, size: :md).with_content("Book a demo")
    end
  end
end
