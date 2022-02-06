#! elixir

src_files = [
  "c_src/evac_nif.c"
]

####

ext_name = case :os.type() do
  {:win32, _} -> "dll"
  _ -> "so"
end

[include_path] = [:lists.concat([:code.root_dir(), '/erts-', :erlang.system_info(:version), '/include'])]

IO.puts("Erlang Include Path: #{include_path}")

System.cmd("zig", [
  "cc",
  "-shared",
  "-undefined dynamic_lookup",
  "-Wl,-undefined=dynamic_lookup",
  "-opriv/evac_nif.#{ext_name}",
  Enum.join(src_files, " "),
  "-I#{include_path}"
])
