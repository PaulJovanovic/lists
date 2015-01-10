module ApplicationHelper
  def api_subdomain
    Rails.env.staging? ? 'api.staging' : 'api'
  end

  def api_domain
    if Rails.env.production? || Rails.env.staging?
      'popjova.com'
    else
      request.host
    end
  end
end
