defmodule RangerWeb.SettingsLiveTest do
  use RangerWeb.ConnCase
  import Phoenix.LiveViewTest

  alias Ranger.User
  alias Ranger.Repo

  test "renders user's information", %{conn: conn} do
    user = create_user()

    {:ok, _view, html} = live(conn, ~p"/users/#{user}/settings")

    assert html =~ user.name
    assert html =~ user.email
  end

  test "users can edit their name", %{conn: conn} do
    user = create_user()
    {:ok, view, _} = live(conn, ~p"/users/#{user}/settings")

    view
    |> element("#name", user.name)
    |> render_click()

    view
    |> form("#name-form", user: %{name: "dude"})
    |> render_submit()

    assert view |> has_element?("#name", "dude")
  end

  test "users can edit their email", %{conn: conn} do
    user = create_user()
    {:ok, view, _} = live(conn, ~p"/users/#{user}/settings")

    view
    |> element("#email", user.email)
    |> render_click()

    view
    |> form("#email-form", user: %{email: "dude@example.com"})
    |> render_submit()

    assert view |> has_element?("#email", "dude@example.com")
  end

  defp create_user(params \\ %{}) do
    %{name: "rando", email: "someone@example.com"}
    |> Map.merge(params)
    |> User.changeset()
    |> Repo.insert!()
  end
end
