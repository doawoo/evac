defmodule EvacTest do
  use ExUnit.Case

  test "Should send 'SIGINT' to the specified process" do
    vm_pid = to_string(:os.getpid())

    Evac.setup(self())

    # Send ourselves a SIGINT
    Task.start(fn ->
      System.cmd("kill", ["-SIGINT", vm_pid]);
    end)

    # Wait a bit
    Process.sleep(500)

    assert_received 'SIGINT'
  end
end
