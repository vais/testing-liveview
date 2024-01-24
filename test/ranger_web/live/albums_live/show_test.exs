defmodule RangerWeb.AlbumsLive.ShowTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Ranger.Album
  alias Ranger.Repo

  @album_name "My Vacation in Spain"
  @album_urls ["image-1.jpg", "image-2.png"]

  test "rendering an album", %{conn: conn} do
    album = Repo.insert!(%Album{name: @album_name, urls: @album_urls})

    {:ok, view, _html} = live(conn, ~p"/albums/#{album}")

    assert has_element?(view, "h2", @album_name)

    for url <- @album_urls do
      assert has_element?(view, "img[data-role=image][src='#{url}']")
    end
  end
end
