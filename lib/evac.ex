defmodule Evac do
  @moduledoc """
  The primary module for Evac, use the "setup" function to start intercepting SIGINT.
  """
  @on_load :init

  @doc """
  Loads the NIF module for Evac, you shouldn't need to call this manually as it's called using `@on_load` in the module itself.
  """
  @spec init :: :ok
  def init do
    nif = :code.priv_dir(:evac) ++ ['/evac_nif']
    :ok = :erlang.load_nif(nif, 0)
  end

  @doc """
  Call this function with a `pid()` you want the message `'SIGINT'` sent to when the VM receives it.

  Please note, you can only have one `pid()` registered to recieve the signal message at a time, calling this twice first with 'A' and then 'B' will result in only pid B recieveing the message!

  The message value sent to the `pid()` will be: `'SIGINT'`
  """
  @spec setup(pid()) :: 0 | 1
  def setup(_pid) do
    exit(:nif_library_not_loaded)
  end
end
