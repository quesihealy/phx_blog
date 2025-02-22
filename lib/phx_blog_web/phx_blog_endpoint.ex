defmodule PhxBlogWeb.PhxBlogEndpoint do
  use Phoenix.Endpoint, otp_app: :phx_blog

  @session_options Application.compile_env!(:phx_blog, :session_options)

  def proxy_endpoint, do: PhxBlogWeb.ProxyEndpoint

  # socket /live must be in the proxy endpoint

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :phx_blog,
    gzip: false,
    # robots.txt is served by Beacon
    only: ~w(assets fonts images favicon.ico)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :phx_blog
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug PhxBlogWeb.Router
end
