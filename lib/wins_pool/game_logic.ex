defmodule WinsPool.GameLogic do
  def determineWinners(games) do
    Enum.map(games, &determineWinner/1)
  end

  def determineWinner(game) do
    cond do
      game["hs"] > game["vs"] ->
        teamNameAsAtom = String.to_atom(game["hnn"])
        mapToRealTeamName[teamNameAsAtom]
      game["hs"] < game["vs"] ->
        teamNameAsAtom = String.to_atom(game["vnn"])
        mapToRealTeamName[teamNameAsAtom]
      true ->
        ""
    end
  end

  def getWinTotals(gameData) do
    gameData
    |> buildWinCountsByTeamName
    |> mapWinCountToDraftChoices
    |> countTotalWinsPerPlayer
  end

  def buildWinCountsByTeamName(%WinsPool.GameData{ namesOfWinners: namesOfWinners } = gameData) do
    winCountsByTeamName = Enum.reduce(namesOfWinners, %{}, fn x, acc ->
      Map.update(acc, x, 1, &(&1 + 1))
    end)

    # IO.puts(inspect(winCountsByTeamName))

    %WinsPool.GameData{ gameData | winCountsByTeamName: winCountsByTeamName }
  end

  def mapWinCountToDraftChoices(%WinsPool.GameData{ winCountsByTeamName: winCountsByTeamName, playersDraft: playersDraft } = gameData) do
    playersDraftWinCount = Enum.map(playersDraft, fn draft ->
      { playerName, draftList } = draft
      winCountList = mapWinCountToPlayerDraft(draftList, winCountsByTeamName)
      %{ name: playerName, winCountList: winCountList }
    end)

    %WinsPool.GameData{ gameData | playersDraftWinCount: playersDraftWinCount }
  end

  def mapWinCountToPlayerDraft(teams, winCountsByTeamName) do
    Enum.map(teams, fn teamName ->
      if Map.has_key?(winCountsByTeamName, teamName) do
        %{ ^teamName => score } = winCountsByTeamName
        %{ teamName: teamName, score: score }
      else
        %{ teamName: teamName, score: 0 }
      end
    end)
  end

  def countTotalWinsPerPlayer(%WinsPool.GameData{ playersDraftWinCount: playersDraftWinCount } = gameData) do
    playersTotalWins = Enum.map(playersDraftWinCount, fn (%{ name: name, winCountList: winCountList } = player) ->
      totalWins = Enum.reduce(winCountList, 0, fn (%{ score: score }, acc) -> acc + score end)
      %{ score: totalWins, name: Atom.to_string(name) }
    end)

    %WinsPool.GameData{ gameData | playersTotalWins: playersTotalWins }
  end

  def mapToRealTeamName do
    [
      cardinals: "Arizona Cardinals",
      falcons: "Atlanta Falcons",
      ravens: "Baltimore Ravens",
      bills: "Buffalo Bills",
      panthers: "Carolina Panthers",
      bears: "Chicago Bears",
      bengals: "Cincinnati Bengals",
      browns: "Cleveland Browns",
      cowboys: "Dallas Cowboys",
      broncos: "Denver Broncos",
      lions: "Detroit Lions",
      packers: "Green Bay Packers",
      texans: "Houston Texans",
      colts: "Indianapolis Colts",
      jaguars: "Jacksonville Jaguars",
      chiefs: "Kansas City Chiefs",
      rams: "Los Angeles Rams",
      chargers: "Los Angeles Chargers",
      dolphins: "Miami Dolphins",
      vikings: "Minnesota Vikings",
      patriots: "New England Patriots",
      saints: "New Orleans Saints",
      giants: "New York Giants",
      jets: "New York Jets",
      raiders: "Oakland Raiders",
      eagles: "Philadelphia Eagles",
      steelers: "Pittsburgh Steelers",
      "49ers": "San Francisco 49ers",
      seahawks: "Seattle Seahawks",
      buccaneers: "Tampa Bay Buccaneers",
      titans: "Tennessee Titans",
      redskins: "Washington Redskins"
    ]
  end
end
