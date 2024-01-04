defmodule RangerWeb.TimelineLiveTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Ranger.Timeline

  test "infinite scrolling", %{conn: conn} do
    [post] = Timeline.posts(offset: 10, limit: 1)

    {:ok, view, _html} = live(conn, ~p"/timeline")

    refute has_element?(view, "[data-role=author]", post.author)
    refute has_element?(view, "[data-role=post]", post.text)

    view
    |> element("#loading", "Loading...")
    |> render_hook("load-more")

    assert has_element?(view, "[data-role=author]", post.author)
    assert has_element?(view, "[data-role=post]", post.text)
  end
end
