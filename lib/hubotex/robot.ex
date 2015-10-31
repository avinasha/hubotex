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
      Hubotex.Rule.Hello.rule,
      Hubotex.Rule.Goodbye.rule
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
end

defmodule Hubotex.Rule.Hello do
  def rule do
    {~r/hello/, &consequence/1}
  end

  defp consequence(_message) do
    "Hai there!"
  end
end

defmodule Hubotex.Rule.Goodbye do
  def rule do
    {~r/goodbye/, &consequence/1}
  end

  defp consequence(_message) do
    "Oh! Dont leave!"
  end
end
