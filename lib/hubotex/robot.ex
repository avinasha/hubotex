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
      {~r/hello/, &hello_consequence/1},
      {~r/goodbye/, &goodbye_consequence/1}
    ]
  end

  defp do_match(message) do
    Enum.reduce_while(rules, {:nomatch, message}, fn rule, acc ->
        {regex, consequence} = rule
        if rule_match?(regex, message), do: {:halt, {:ok, consequence.(message)}}, else: {:cont, acc}
    end)
  end

  defp rule_match?(regex, message) do
    Regex.match?(regex, message)
  end

  defp hello_consequence(_message) do
    "Hai there!"
  end

  defp goodbye_consequence(_message) do
    "Oh! Dont leave!"
  end
end
