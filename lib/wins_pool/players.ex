defmodule WinsPool.Players do
  def initialize (gameData) do
    getPlayersAndTheirDrafts(gameData)
    |> definePlayersByName
  end

  def getPlayersAndTheirDrafts(gameData) do
    playersDraft = [
      alex: [
        "Seattle Seahawks",
        "Tennessee Titans",
        "Minnesota Vikings",
        "San Francisco 49ers"
      ],
      jace: [
        "New England Patriots",
        "Carolina Panthers",
        "Miami Dolphins",
        "Jacksonville Jaguars"
      ],
      ray: [
        "Pittsburgh Steelers",
        "New Orleans Saints",
        "Detroit Lions",
        "Chicago Bears"
      ],
      kawika: [
        "Atlanta Falcons",
        "Kansas City Chiefs",
        "Tampa Bay Bucs",
        "Cincinnati Bengals"
      ],
      justin: [
        "Dallas Cowboys",
        "Denver Broncos",
        "Houston Texans",
        "Indianapolis Colts"
      ],
      andy: [
        "Green Bay Packers",
        "Las Vegas Raiders",
        "Los Angeles Chargers",
        "Washington Redskins"
      ]
    ]

    %WinsPool.GameData{gameData | playersDraft: playersDraft}
  end

  def definePlayersByName(gameData) do
    %{playersDraft: playersDraft} = gameData
    %WinsPool.GameData{gameData | players: Keyword.keys(playersDraft)}
  end
end