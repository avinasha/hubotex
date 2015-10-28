defmodule Hubotex.Robot do
  def receive(message) do
    message
    |> match
    |> respond
  end

  def match(message) do
    do_match(message)
  end

  def respond(message) do
    message
  end

  defp do_match(message) do
    cond do
      Regex.match?(~r/hello/, message) -> {:ok, "Hai there!"}
      Regex.match?(~r/goodbye/, message) -> {:ok, "Oh! Dont leave!"}
      true -> {:nomatch, message}
    end
  end
end
