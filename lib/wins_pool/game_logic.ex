defmodule WinsPool.GameLogic do
  def determineWinners(games) do
    Enum.map(games, fn game ->
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
    end)
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
