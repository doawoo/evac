defmodule Mix.Tasks.Compile.Nif do
  def run(_args) do
    {result, _errcode} = System.cmd("make", [])
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
    ]
  end
end
