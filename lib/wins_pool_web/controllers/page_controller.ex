defmodule WinsPoolWeb.PageController do
  use WinsPoolWeb, :controller
  require WinsPool.RemoteAPI, as: API
  require WinsPool.Players, as: Players

  def index(conn, _params) do
    gameData = API.getWinnersOnly() # prolly move this to /api/ route for spa
    |> Players.initialize

    %{
      namesOfWinners: namesOfWinners,
      players: players
    } = gameData

    IO.puts(inspect(players))

    render conn, "index.html", winners: namesOfWinners
  end
end
