defmodule Graphene.IdStore do
  @moduledoc """
  Holds state with data linking jsonrpc call ids and params for pattern
  matching in the handler
  """

  def start_link do
    Agent.start_link(fn -> Map.new end, name: __MODULE__)
  end

  def get(id) do
    Agent.get_and_update(__MODULE__, fn map ->
      map |> Map.pop(String.to_integer(id))
    end)
  end

  def put(id, {pid, params}) do
    Agent.update(__MODULE__, fn map ->
      Map.put(map, id, {pid, params})
    end)
  end
end
