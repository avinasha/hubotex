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
    if Regex.match?(~r/hello/, message) do
      result = {:ok, "Hai there!"}
    end
    result
  end
end
