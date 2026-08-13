module Landing
  # @label Metrics
  class MetricsComponentPreview < Lookbook::Preview
    def default
      render Landing::MetricsComponent.new
    end
  end
end
