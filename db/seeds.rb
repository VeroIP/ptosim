# Bootstraps the site admin. Idempotent: safe to run repeatedly. If the admin
# already has a password, no invitation is issued.

ADMIN_EMAIL = ENV.fetch("ADMIN_EMAIL", "admin@ptosim.com")

admin = User.find_or_initialize_by(email_address: ADMIN_EMAIL)

if admin.new_record?
  admin.role = :admin
  admin.save!(validate: false)
end

if admin.password_digest.present?
  puts "Admin #{admin.email_address} already has a password. No invite issued."
  puts "Sign in at: /console/sign_in"
else
  admin.issue_invitation!
  puts ""
  puts "=" * 72
  puts " Site admin bootstrap"
  puts "=" * 72
  puts "  Email: #{admin.email_address}"
  puts "  Role:  #{admin.role}"
  puts ""
  puts "  Claim this invitation to set the initial password:"
  puts ""
  puts "    /invitations/#{admin.invite_token}/edit"
  puts ""
  puts "  Full URL (adjust host as needed):"
  puts "    http://localhost:3000/invitations/#{admin.invite_token}/edit"
  puts ""
  puts "  Expires: #{User::INVITE_VALID_FOR.inspect} from now"
  puts "=" * 72
  puts ""
end
