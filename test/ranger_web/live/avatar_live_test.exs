defmodule RangerWeb.AvatarLiveTest do
  use RangerWeb.ConnCase
  import Phoenix.LiveViewTest

  test "renders avatar for a given email", %{conn: conn} do
    email = "someone@example.com"
    avatar_url = Ranger.Gravatar.generate_url(email)

    {:ok, view, _html} = live(conn, ~p"/avatar/#{email}")

    assert has_element?(view, ~s(img.avatar[src="#{avatar_url}"][alt="#{email}"]))
  end
end
