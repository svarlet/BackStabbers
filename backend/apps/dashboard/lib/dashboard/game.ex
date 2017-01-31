defmodule Dashboard.Game do
  defstruct players: []
end

defmodule Dashboard.Class do
  defstruct name: "None"
end

defmodule Dashboard.Race do
  defstruct name: "Human"
end

defmodule Dashboard.PlayerStats do
  defstruct level: 1,
    force: 0
end

defmodule Dashboard.Player do
  defstruct name: "",
    sex: nil,
    class: %Dashboard.Class{},
    race: %Dashboard.Race{},
    stats: %Dashboard.PlayerStats{}
end
