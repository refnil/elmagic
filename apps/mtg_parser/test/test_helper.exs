ExUnit.configure(exclude: [:disabled, :long])
ExUnit.start
Code.require_file "macro.exs", __DIR__
