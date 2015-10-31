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

  def rules do
    [
      {~r/hello/, "Hai there!"},
      {~r/goodbye/, "Oh! Dont leave!"}
    ]
  end

  defp do_match(message) do
    Enum.reduce_while(rules, {:nomatch, message}, fn rule, acc ->
        {regex, consequence} = rule
        if rule_match?(regex, message), do: {:halt, {:ok, consequence}}, else: {:cont, acc}
    end)
  end

  defp rule_match?(regex, message) do
    Regex.match?(regex, message)
  end
end
