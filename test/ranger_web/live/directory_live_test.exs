defmodule RangerWeb.DirectoryLiveTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Ranger.Directory

  test "user can select a member", %{conn: conn} do
    member = Directory.find_by(name: "Legolas")
    {:ok, view, _html} = live(conn, ~p"/directory")

    refute has_element?(view, "#active-member", "Legolas")

    view
    |> element("[data-role=member]", "Legolas")
    |> render_click()

    assert_patch(view, ~p"/directory/#{member.id}")

    assert has_element?(view, "#active-member", "Legolas")
  end

  test "user can visit a member", %{conn: conn} do
    member = Directory.find_by(name: "Legolas")

    {:ok, view, _} = live(conn, ~p"/directory/#{member.id}")

    assert has_element?(view, "#active-member", member.name)
  end
end
