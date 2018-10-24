defmodule FFT.MixProject do
  use Mix.Project

  def project do
    [
      app: :fft,
      version: "0.1.2",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "FFT",
      docs: [markdown_processor: ExDoc.Markdown.Cmark],
      source_url: "https://github.com/brunosantanaa/fft"
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
      {:cmark, "~> 0.6", only: :dev},
      {:ex_doc, ">=0.0.0", only: :dev},
      {:complex_num, "~>1.0.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp description() do
    "Calculation of the fast fourier transform, in the first version for lists of maximum 8bits."
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "fft",
      # These are the default files included in the package
      files: ~w( lib .formatter.exs mix.exs README* ),
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/brunosantanaa/fft"}
    ]
  end
end
