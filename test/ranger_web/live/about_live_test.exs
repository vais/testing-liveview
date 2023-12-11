defmodule RangerWeb.AboutLiveTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Ranger.FellowshipMember

  test "viewing the cast of characters", %{conn: conn} do
    {:ok, _view, html} = live conn, ~p"/about"

    for character <- FellowshipMember.characters() do
      assert html =~ character.name
      assert html =~ character.type
      assert html =~ character.description
    end
  end
end
