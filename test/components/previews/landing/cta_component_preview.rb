module Landing
  # @label CTA
  class CtaComponentPreview < Lookbook::Preview
    def default
      render Landing::CtaComponent.new
    end
  end
end
