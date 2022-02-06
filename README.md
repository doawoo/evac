# Evac

Evac is a simple C NIF for Elixir/Erlang that catches `SIGINT`.

The API is incredibly simple:

```elixir
# Call the setup function with the PID you want to receive the `'SIGINT'` message...
# We'll use self() for now...
Evac.setup(self())

# Now if the VM process is sent the SIGINT message (Like from pressing Ctrl-C)
# we can do something with it

receive do
  'SIGINT' ->
    IO.puts("Got Interrupt Signal!")
    System.halt(0)
end
```