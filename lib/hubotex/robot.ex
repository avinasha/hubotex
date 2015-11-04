defmodule Hubotex.Robot do
  use GenServer
  
  def start_link(rules) do
    GenServer.start_link(__MODULE__, [rules: rules], name: __MODULE__)
  end
  
  def accept(message) do
    GenServer.call(__MODULE__, {:accept, message})
  end
  
  ### CallBacks ###

  def handle_call({:accept, message}, _from, state) do
    {:reply, do_accept(message, state), state}
  end



  
  defp do_accept(message, state) do
    {message, state}
    |> do_match
    |> do_respond
  end

  defp do_match({message, state}) do
    {message, state[:rules]}
    |> map_rules
    |> reject_no_match
    |> acc_results
  end

  defp do_respond(message), do: message


  defp map_rules({message, rules}) do
    results = Enum.map(rules, fn rule ->
      {regex, consequence} = rule
      if rule_match?(regex, message), do: {:ok, consequence.(message)}, else: {:nomatch}
    end)
    {message, results}
  end

  defp reject_no_match({message, results}) do
    results = Enum.reject(results, fn result -> result == {:nomatch} end)
    {message, results}
  end

  defp acc_results({message, []}), do: {:nomatch, message}
  defp acc_results({_message, results}), do: Enum.reduce(results, fn {:ok, result}, {:ok, response} -> {:ok, "#{response}\n#{result}"} end)



  defp rule_match?(regex, message) do
    Regex.match?(regex, message)
  end
end
