# Exwebapp

Basic boilerplate for building a webapp in Elixir.

Mostly for my own reference and testing out features in plug_cowboy.

## Installation

From GitHub:

```elixir
def deps do
  [
    {:exwebapp, git, "https://github.com/norrland/exwebapp", tag: "0.1"}
  ]
end
```

## Certificates creation

Setup development certificate/key/dhparams.

```
$ openssl req -x509 -newkey rsa:4096 -nodes -keyout priv/tls/exwebapp_dev_key.pem \
  -out priv/tls/exwebapp_dev_cert.pem -days 3650 -subj '/CN=exwebapp.localhost'
$ openssl dhparam -out priv/tls/exwebapp_dev_dhparam.pem 4096 # This will take a long time on slow computers
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/exwebapp](https://hexdocs.pm/exwebapp).

