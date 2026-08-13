module Ui
  # @label Eyebrow
  class EyebrowComponentPreview < Lookbook::Preview
    def accent
      render Ui::EyebrowComponent.new(tone: :accent).with_content("Prosecution simulation")
    end

    def muted
      render Ui::EyebrowComponent.new(tone: :muted).with_content("The record")
    end

    # @display background_color "oklch(0.24 0.025 255)"
    def dark
      render Ui::EyebrowComponent.new(tone: :dark).with_content("Decision data")
    end
  end
end
