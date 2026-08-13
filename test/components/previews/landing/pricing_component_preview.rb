module Landing
  # @label Pricing
  class PricingComponentPreview < Lookbook::Preview
    def default
      render Landing::PricingComponent.new
    end
  end
end
