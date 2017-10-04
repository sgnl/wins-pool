defmodule WinsPoolWeb.PageController do
  use WinsPoolWeb, :controller
  require WinsPool.RemoteAPI, as: RemoteAPI
  require WinsPool.Players, as: Players
  require WinsPool.GameLogic, as: GameLogic

  def index(conn, _params) do
    gameData = RemoteAPI.getWinnersOnly()
    |> Players.initialize
    |> GameLogic.getWinTotals

    render conn, "index.html",
      playersTotalWins: Enum.sort(gameData.playersTotalWins, fn a, b ->
        a.score >= b.score
      end)
  end
end
