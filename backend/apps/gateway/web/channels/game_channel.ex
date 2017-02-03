defmodule Gateway.GameChannel do
  use Gateway.Web, :channel

  alias Dashboard.GameServer

  def join("game:"<>id, %{"username": username}, socket) do
    with {:ok, game_pid} <- Dashboard.start_game_server(id),
         {:ok, game} <- GameServer.add_player(game_pid, username),
           :ok <- broadcast(socket, "new_player", game) do
      {:ok, game, socket}
    else
      {:error, reason} -> {:error, reason}
    end
  end

end
