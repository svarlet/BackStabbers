defmodule Gateway.GameChannel do
  use Gateway.Web, :channel

  alias Dashboard.GameServer

  def join("game:"<>id, %{"username": username}, socket) do
    with {:ok, {player_id, _game}} <- GameServer.add_player({:global, id}, username),
           _ <- send(self(), {:broadcast_state, "new_player"}) do
      {:ok, %{player_id: player_id}, socket}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def join("game:"<>_id, _payload, _socket) do
    {:error, :missing_username}
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
