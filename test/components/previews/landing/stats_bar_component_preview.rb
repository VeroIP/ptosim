module Landing
  # @label Stats bar
  class StatsBarComponentPreview < Lookbook::Preview
    def default
      render Landing::StatsBarComponent.new
    end
  end
end
