defmodule RangerWeb.WeAreLiveTest do
  use RangerWeb.ConnCase
  import Phoenix.LiveViewTest

  test "renders disconnected state", %{conn: conn} do
    conn = get(conn, ~p"/we-are-live")
    assert html_response(conn, 200) =~ "Not connected yet"
  end

  test "renders connected state", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/we-are-live")
    assert render(view) =~ "Now we are cooking with gas!"
  end
end
