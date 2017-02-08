defmodule Gateway.GameControllerTest do
  use Gateway.ConnCase, async: true

  test "new/2 returns the id of the newly created game" do
    response =
      build_conn()
      |> get("/api/game/new")
      |> json_response(200)

    assert is_pid(:global.whereis_name(response["game_id"]))
  end
end
