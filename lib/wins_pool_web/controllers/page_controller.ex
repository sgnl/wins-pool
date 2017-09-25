defmodule WinsPoolWeb.PageController do
  use WinsPoolWeb, :controller
  require WinsPool.RemoteAPI, as: API

  def index(conn, _params) do
    result = API.getNamesOfWinners() # prolly move this to /api/ route for spa

    render conn, "index.html", winners: result
  end
end
