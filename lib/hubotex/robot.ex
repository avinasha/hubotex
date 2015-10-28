defmodule Hubotex.Robot do
  def receive(message) do
    message
    |> match
    |> respond
  end

  def match(message) do
    IO.puts "Nothing to match"
    message
  end

  def respond(message) do
    IO.puts "#{message}"
  end
end
