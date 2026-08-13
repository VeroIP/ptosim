module Landing
  # @label Footer
  class FooterComponentPreview < Lookbook::Preview
    def default
      render Landing::FooterComponent.new
    end
  end
end
