defmodule RangerWeb.MetricsLiveTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders loading indicator while loading metrics", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/metrics")
    assert has_element?(view, "[data-role=loading]")
    refute has_element?(view, "[data-role=result]")
    refute has_element?(view, "[data-role=failed]")
  end

  test "renders metrics once they're loaded", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/metrics")

    render_async(view, 2000)

    refute has_element?(view, "[data-role=loading]")
    assert has_element?(view, "[data-role=result]")
    refute has_element?(view, "[data-role=failed]")
  end

  test "renders error on failure", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/metrics?__test_metrics_fail__=a")

    render_async(view, 2000)

    refute has_element?(view, "[data-role=loading]")
    refute has_element?(view, "[data-role=result]")
    assert has_element?(view, "[data-role=failed]")
  end
end
