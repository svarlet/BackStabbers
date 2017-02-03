defmodule Gateway.GameChannel do
  use Gateway.Web, :channel

  alias Dashboard.GameServer

  def join("game:"<>id, %{"username": username}, socket) do
    with {:ok, game_pid} <- Dashboard.start_game_server(id),
         {:ok, game} <- GameServer.add_player(game_pid, username),
           _ <- send(self(), {:broadcast_state, "new_player"}) do
      {:ok, socket}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def handle_info({:broadcast_state, reason}, socket) do
    id =
      socket.topic
      |> String.split(":")
      |> Enum.at(1)
    {:ok, game} = GameServer.get_state({:global, id})
    broadcast socket, reason, game
    {:noreply, socket}
  end

end
