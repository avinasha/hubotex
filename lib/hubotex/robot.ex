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

  ### end CallBacks ###

  defp do_accept(message, state) do
    {message, state}
    |> do_match
    |> do_respond
  end

  defp do_match({message, state}) do
    Hubotex.Matcher.match(message, state[:rules])
  end

  defp do_respond(message), do: message
end
