module Console
  # @label Invite card
  class InviteCardComponentPreview < Lookbook::Preview
    def pending_admin
      user = User.new(
        email_address: "admin+preview@ptosim.com",
        role: :admin,
        invite_sent_at: 2.days.ago
      )
      render Console::InviteCardComponent.new(
        user: user,
        invite_url: "http://localhost:3000/invitations/preview-token-abc123xyz/edit"
      )
    end

    def pending_member
      user = User.new(
        email_address: "counsel@acme-ip.com",
        role: :member,
        invite_sent_at: 6.hours.ago
      )
      render Console::InviteCardComponent.new(
        user: user,
        invite_url: "http://localhost:3000/invitations/preview-token-def456uvw/edit"
      )
    end

    def with_custom_help_text
      user = User.new(
        email_address: "sales@ptosim.com",
        role: :sales,
        invite_sent_at: 1.day.ago
      )
      render Console::InviteCardComponent.new(
        user: user,
        invite_url: "http://localhost:3000/invitations/preview-token-ghi789rst/edit",
        help_text: "Copy the link above into a signed email — never share via chat."
      )
    end
  end
end
