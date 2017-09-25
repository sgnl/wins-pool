defmodule WinsPool.RemoteAPI do
  import HTTPoison
  require XmlToMap
  require WinsPool.GameLogic, as: GameLogic

  def getNamesOfWinners do
    getWeeksData
    |> Enum.map(&convertXMLToMap/1)
    |> Enum.map(&GameLogic.determineWinners/1)
    |> Enum.concat
    |> Enum.filter(fn string -> String.length(string) > 0 end)
  end

  def getWeeksData do
    weeksRequestList = for i <- 1..17 do
      Task.async(fn ->
        get!("http://www.nfl.com/ajax/scorestrip?season=2017&seasonType=REG&week=#{i}")
      end)
    end

    weeksRequestList
    |> Enum.map(&Task.await/1)
  end

  defp convertXMLToMap(%HTTPoison.Response{body: body}) do
    # also trims some fat (useless nested levels)
    XmlToMap.naive_map(body)["ss"]["gms"]["g"]
  end
end