defmodule Deal.Mixfile do
  use Mix.Project

  def project do
    [
      app: :deal,
      version: "1.0.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/xvw/deal"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Deal is a shortcut to chain function that returns 
    data using the pattern `{:ok, value}`.
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :postgrex,
      files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      maintainers: ["Xavier Van de Woestyne"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/xvw/deal"}
    ]
  end

end
