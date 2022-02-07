defmodule Mix.Tasks.Compile.Nif do
  def run(_args) do
    {result, _errcode} = System.cmd("elixir", ["./make.exs"])
    IO.binwrite(result)
  end
end

defmodule Evac.MixProject do
  use Mix.Project

  def project do
    [
      app: :evac,
      package: [
        licenses: ["MIT"],
        links: %{"Github" => "https://github.com/doawoo/evac"},
      ],
      description: "A simple way to catch SIGINT in Elixir.",
      compilers: [:elixir_make | Mix.compilers()],
      make_targets: ["all"],
      make_clean: ["clean"],
      version: "0.2.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [main: "readme", extras: ["README.md"]]
    ]
  end

  def deps do
    [
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
      {:elixir_make, "~> 0.6", runtime: false}
    ]
  end
end
