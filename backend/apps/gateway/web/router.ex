defmodule Gateway.Router do
  use Gateway.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Gateway do
    pipe_through :api
    get "/game/new", GameController, :new
  end
end
