defmodule RangerWeb.NewsletterLiveTest do
  use RangerWeb.ConnCase
  import Phoenix.LiveViewTest

  test "shows a message that encourages users to subscribe", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/newsletter")
    selector = "[data-role=subscribe-message]"
    text = "No spam ever. Unsubscribe any time!"
    assert has_element?(view, selector, text)
  end

  test "users can click a button to subscribe", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/newsletter")
    selector = "form button"
    text = "Subscribe"
    assert has_element?(view, selector, text)
  end

  test "warns users about invalid email address as they type", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/newsletter")

    html =
      view
      |> form("form", %{subscription: %{email: "anything"}})
      |> render_change()

    assert html =~ "has invalid format"
  end
end
