defmodule Mix.Tasks.Count do
  use Mix.Task

  def run([]) do
    MTGJson.start
    set = "AllCards"
    {:ok, reponse} = MTGJson.get(set)
    card_list = Dict.values(reponse.body)

    count_working(set,card_list)

  end

  def run([set]) do
    MTGJson.start
    {:ok, reponse} = MTGJson.get(set)
    card_list = reponse.body["cards"]

    count_working(set,card_list)
  end

  defp parse_task(%{"text" => text}) do
    case ExParsec.parse_value(text, MtgParser.parse_text) do
      {:ok,_s,_r} -> :ok
      _ -> :error
    end
  end
  defp parse_task(_var) do
    :ok
  end

  defp exe_fun(list,task) do
    size = div(Enum.count(list) ,3)
    list_of_list = Enum.chunk(list,size,size,[])
    list_fun = fn list -> fn -> Enum.map(list,task) end end
    tasks = Enum.map(list_of_list,&(Task.async(list_fun.(&1))))
    Enum.flat_map(tasks, &(Task.await(&1,180 * 1000)))
  end

  defp count_working(for,card_list) do
    total = Enum.count(card_list)

    working = exe_fun(card_list,&parse_task/1)

    ok = Enum.count(working, &(&1 == :ok))
    Mix.shell.info "For    : " <> for
    Mix.shell.info "Working: " <> to_string(ok)
    Mix.shell.info "Total  : " <> to_string(total)
  end
end
