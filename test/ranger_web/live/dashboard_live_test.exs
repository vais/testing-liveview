defmodule RangerWeb.DashboardLiveTest do
  use RangerWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "navigating outside the live view" do
    test "clicking href link (error tuple edition)", %{conn: conn} do
      {:ok, view, _} = live(conn, ~p"/dashboard")

      {:error, {:redirect, %{to: path}}} =
        view
        |> element(~s(a[href="/"]))
        |> render_click()

      assert path == ~p"/"
    end

    test "clicking href link (assert_redirect edition)", %{conn: conn} do
      {:ok, view, _} = live(conn, ~p"/dashboard")

      view
      |> element(~s(a[href="/"]))
      |> render_click()

      {path, _flash} = assert_redirect(view)

      assert path == ~p"/"
    end

    test "clicking href link (follow_redirect edition)", %{conn: conn} do
      {:ok, view, _} = live(conn, ~p"/dashboard")

      {:ok, conn} =
        view
        |> element(~s(a[href="/"]))
        |> render_click()
        |> follow_redirect(conn, ~p"/")

      html = html_response(conn, 200)
      assert html =~ "Peace of mind from prototype to production"
    end
  end

  describe "navigating to another live view in live_session" do
    test "clicking navigate link (error tuple edition)", %{conn: conn} do
      {:ok, view, _} = live(conn, ~p"/dashboard")

      {:error, {:live_redirect, %{to: path}}} =
        view
        |> element("[data-role=page-link]", "Team")
        |> render_click()

      assert path == ~p"/team"
    end

    test "clicking navigate link (assert_redirect edition)", %{conn: conn} do
      {:ok, view, _} = live(conn, ~p"/dashboard")

      view
      |> element("[data-role=page-link]", "Team")
      |> render_click()

      {path, _flash} = assert_redirect(view)

      assert path == ~p"/team"
    end

    test "clicking navigate link (follow_redirect edition)", %{conn: conn} do
      {:ok, view, _} = live(conn, ~p"/dashboard")

      {:ok, team_view, _team_html} =
        view
        |> element("[data-role=page-link]", "Team")
        |> render_click()
        |> follow_redirect(conn, ~p"/team")

      assert has_element?(team_view, "h1", "Team")
    end
  end
end
