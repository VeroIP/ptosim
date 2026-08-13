module Ui
  # @label Section heading
  class SectionHeadingComponentPreview < Lookbook::Preview
    def with_eyebrow_and_lede
      render Ui::SectionHeadingComponent.new(
        eyebrow: "Decision data",
        title: "Choose the path with the numbers in front of you.",
        lede: "Each simulated path carries a cost, a timeline, and a scope consequence."
      )
    end

    def centered
      render Ui::SectionHeadingComponent.new(
        title: "Pricing",
        lede: "An annual platform license plus a per-simulation rate.",
        align: :center
      )
    end

    def title_only
      render Ui::SectionHeadingComponent.new(title: "How it works")
    end

    # @display background_color "oklch(0.24 0.025 255)"
    def dark
      render Ui::SectionHeadingComponent.new(
        eyebrow: "The record",
        title: "Every round, with the examiner's reasoning attached.",
        lede: "You see the rejection, the response, and exactly which claim language moved.",
        tone: :dark
      )
    end
  end
end
