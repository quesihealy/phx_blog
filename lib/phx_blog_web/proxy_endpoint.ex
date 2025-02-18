defmodule PhxBlogWeb.ProxyEndpoint do
  use Beacon.ProxyEndpoint,
    otp_app: :phx_blog,
    session_options: Application.compile_env!(:phx_blog, :session_options),
    fallback: PhxBlogWeb.Endpoint
end
