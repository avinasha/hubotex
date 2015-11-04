defmodule Hubotex.Rule.Goodbye do
  def rule do
    {~r/goodbye/, &consequence/1}
  end

  defp consequence(_message) do
    "Oh! Dont leave!"
  end
end
