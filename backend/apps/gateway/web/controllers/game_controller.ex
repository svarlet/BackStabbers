defmodule Gateway.GameController do
  use Gateway.Web, :controller

  alias GameId.GenGameId

  def new(conn, _params) do
    game_id = GenGameId.generate
    Dashboard.start_game_server(game_id)
    json conn, %{game_id: game_id}
  end
end
