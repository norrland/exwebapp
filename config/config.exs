use Mix.Config

# specify which scheme to use
config :exwebapp, scheme: :http

# provide both http and https configuration options.
config :exwebapp, :plug_cowboy,
  http: [
    port: 4000
  ],
  https: [
    port: 4443,
    # set otp_app when using relative paths to certs
    otp_app: :exwebapp,
    keyfile: "priv/tls/exwebapp_key.pem",
    certfile: "priv/tls/exwebapp_cert.pem",
    dhfile: "priv/tls/exwebapp_dhparam.pem",
    # versions: only use these versions.
    versions: [:"tlsv1.2"],
    secure_renegotiate: true,
    reuse_sessions: true
    # for other options, see https://hexdocs.pm/plug/Plug.SSL.html
  ]

config :logger, :level, :warn
