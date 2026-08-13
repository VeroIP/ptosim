module Landing
  # @label How it works
  class HowItWorksComponentPreview < Lookbook::Preview
    def default
      render Landing::HowItWorksComponent.new
    end
  end
end
