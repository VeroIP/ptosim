class Rack::Attack
  # Store: memory in dev/test, Solid Cache in prod (Rails.cache).
  Rack::Attack.cache.store = Rails.cache

  # -------- Throttles --------------------------------------------------------

  # Login attempts by IP: 10 per 5 min
  throttle("sign_in/ip", limit: 10, period: 5.minutes) do |req|
    req.ip if req.path == "/console/sign_in" && req.post?
  end

  # Login attempts by submitted email: 5 per 20 min
  throttle("sign_in/email", limit: 5, period: 20.minutes) do |req|
    if req.path == "/console/sign_in" && req.post?
      req.params["email_address"].to_s.downcase.strip.presence
    end
  end

  # TOTP verify attempts by IP: 10 per 5 min
  throttle("two_factor/ip", limit: 10, period: 5.minutes) do |req|
    req.ip if req.path.start_with?("/console/two_factor") && req.post?
  end

  # Invitation claim attempts by IP: 20 per hour
  throttle("invitations/ip", limit: 20, period: 1.hour) do |req|
    req.ip if req.path.start_with?("/invitations/") && (req.post? || req.patch?)
  end

  # -------- Response ---------------------------------------------------------

  self.throttled_responder = lambda do |request|
    retry_after = (request.env["rack.attack.match_data"] || {})[:period]
    [
      429,
      { "Content-Type" => "text/plain", "Retry-After" => retry_after.to_s },
      ["Too many requests. Try again in a moment.\n"]
    ]
  end
end

Rails.application.config.middleware.use Rack::Attack
