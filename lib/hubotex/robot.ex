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
    do_match({message, state})
    |> do_respond
  end

  defp do_match({message, state}) do
    Enum.reduce_while(state[:rules], {:nomatch, message}, fn rule, acc ->
        {regex, consequence} = rule
        if rule_match?(regex, message), do: {:halt, {:ok, consequence.(message)}}, else: {:cont, acc}
    end)
  end

  defp do_respond(message) do
    message
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
