defmodule Hubotex.Rule.Hello do
  def rule do
    {~r/hello/, &consequence/1}
  end

  defp consequence(_message) do
    "Hai there!"
  end
end

