defmodule WinsPoolWeb.PageView do
  use WinsPoolWeb, :view

  def getPlayerName(%{name: name}), do: name
  def getPlayerScore(%{score: score}), do: score
end
