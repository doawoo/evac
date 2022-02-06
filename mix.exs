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
      compilers: [:nif] ++ Mix.compilers,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "README",
        extras: ["README.md"]
      ]
    ]
  end

  def deps do
    [
      {:ex_doc, "~> 0.28", only: :dev, runtime: false}
    ]
  end
end
