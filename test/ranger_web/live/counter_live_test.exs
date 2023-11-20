defmodule RangerWeb.CounterLiveTest do
  use RangerWeb.ConnCase
  import Phoenix.LiveViewTest

  test "counter starts out at zero", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/counter")
    assert has_element?(view, "#count", "0")
  end

  test "user can click to increment the counter", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/counter")

    view
    |> element("#increment")
    |> render_click()

    assert has_element?(view, "#count", "1")
  end

  test "user can click to decrement the counter", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/counter")

    view
    |> element("#decrement")
    |> render_click()

    assert has_element?(view, "#count", "-1")
  end
end
