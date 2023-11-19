defmodule RangerWeb.GreetLiveTest do
  use RangerWeb.ConnCase
  import Phoenix.LiveViewTest

  test "renders disconnected state", %{conn: conn} do
    conn = get(conn, ~p"/greet")
    assert html_response(conn, 200) =~ "dead view"
  end

  test "renders connected state", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/greet")
    assert html =~ "live view"
  end

  test "rendering with the view", %{conn: conn} do
    {:ok, view, _html} = live conn, ~p"/greet"
    assert render(view) =~ "live view"
  end
end
