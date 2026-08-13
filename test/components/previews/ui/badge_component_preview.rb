module Ui
  # @label Badge
  class BadgeComponentPreview < Lookbook::Preview
    def beta
      render Ui::BadgeComponent.new(label: "Beta")
    end

    def alpha
      render Ui::BadgeComponent.new(label: "Alpha")
    end
  end
end
