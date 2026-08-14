module Ui
  # @label Copy button
  class CopyButtonComponentPreview < Lookbook::Preview
    def labeled_small
      render Ui::CopyButtonComponent.new(value: "https://ptosim.com/invitations/abc123/edit")
    end

    def labeled_medium
      render Ui::CopyButtonComponent.new(
        value: "https://ptosim.com/invitations/abc123/edit",
        size: :md
      )
    end

    def icon_only
      render Ui::CopyButtonComponent.new(
        value: "https://ptosim.com/invitations/abc123/edit",
        variant: :icon,
        label: "Copy invite URL"
      )
    end

    def custom_labels
      render Ui::CopyButtonComponent.new(
        value: "SIM-4471",
        label: "Copy sim ID",
        copied_label: "Copied ID"
      )
    end
  end
end
