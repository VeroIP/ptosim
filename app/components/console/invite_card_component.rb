module Console
  # Card that shows an invitation URL with a copy button. Used on both the
  # org-user show page and the staff show page — same UI, same affordances.
  class InviteCardComponent < ApplicationComponent
    def initialize(user:, invite_url:, help_text: nil)
      @user = user
      @invite_url = invite_url
      @help_text = help_text
    end

    def expires_on
      (@user.invite_sent_at + User::INVITE_VALID_FOR).to_date.iso8601
    end

    def default_help_text
      "Single-use. Send this to #{@user.email_address} — they'll set their password" \
        "#{' and enroll two-factor' if @user.two_factor_required?} on first visit."
    end
  end
end
