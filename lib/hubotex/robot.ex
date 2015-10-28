defmodule Hubotex.Robot do
  def receive(message) do
    message
    |> match
    |> respond
  end

  def match(message) do
    message = do_match(message)
    message
  end

  def respond(message) do
    IO.puts "#{message}"
  end

  defp do_match(message) do
    if Regex.match?(~r/hello/, message) do
      message = "Hai there!"
    end
    message
  end
end
