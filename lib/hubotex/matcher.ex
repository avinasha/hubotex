defmodule Hubotex.Matcher do

  def match(message, rules) do
    {message, rules}
    |> map_rules
    |> reject_no_match
    |> acc_results
  end

  defp map_rules({message, rules}) do
    results = Enum.map(rules, fn rule ->
      {regex, consequence} = rule
      if rule_match?(regex, message) do
        {:ok, consequence.(message)}
      else
        {:nomatch}
      end
    end)
    {message, results}
  end
 
  defp reject_no_match({message, results}) do
    results = Enum.reject(results, fn result -> result == {:nomatch} end)
    {message, results}
  end
  
  defp acc_results({message, []}), do: {:nomatch, message}
  defp acc_results({_message, results}) do
    Enum.reduce(results, fn {:ok, result}, {:ok, acc_response} ->
      {:ok, "#{acc_response}\n#{result}"}
    end)
  end
  
  defp rule_match?(regex, message) do
    Regex.match?(regex, message)
  end 
end
