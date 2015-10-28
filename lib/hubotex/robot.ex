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
    message
  end

  defp do_match(message) do
    result = {:nomatch, message}
    cond do
      Regex.match?(~r/hello/, message) -> result = {:ok, "Hai there!"}
      Regex.match?(~r/goodbye/, message) -> result = {:ok, "Oh! Dont leave!"}
      true -> 
    end
    result
  end
end
