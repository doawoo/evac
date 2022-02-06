defmodule Evac do
  @on_load :init

  @spec init :: :ok
  def init do
    :ok = :erlang.load_nif('./priv/evac_nif', 0)
  end

  @doc """
  Call this function with a `pid()` you want the message `'SIGINT'` sent to when the VM receives it.

  Please note, you can only have one `pid()` registered to recieve the signal message at a time, calling this twice first with pid A and then pid B
  will result in only pid B recieveing the message!
  """
  @spec setup(pid()) :: 0 | 1
  def setup(_pid) do
    exit(:nif_library_not_loaded)
  end
end
