module Landing
  # @label Header
  class HeaderComponentPreview < Lookbook::Preview
    def default
      render Landing::HeaderComponent.new
    end
  end
end
