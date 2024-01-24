defmodule RangerWeb.AlbumsLive.NewTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  @filename "apple.png"

  test "previewing uploads", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    view
    |> upload(@filename)

    assert has_element?(view, ~s([data-role=image-preview][data-name="#{@filename}"]))
  end

  test "canceling an upload", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    view
    |> upload(@filename)
    |> cancel_upload

    refute has_element?(view, ~s([data-role=image-preview][data-name="#{@filename}"]))
  end

  test "error when uploading too many files", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    view
    |> upload(@filename)
    |> upload(@filename)
    |> upload(@filename)
    |> upload(@filename)

    assert render(view) =~ "too_many_files"
  end

  test "error when album name is blank (on change)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    view
    |> form("#upload-form", %{album: %{name: ""}})
    |> render_change

    assert has_element?(view, "p", "can't be blank")
  end

  test "error when album name is blank (on submit)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    view
    |> form("#upload-form", %{album: %{name: ""}})
    |> render_submit

    assert has_element?(view, "p", "can't be blank")
  end

  test "creating an album", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    {:ok, next_view, _html} =
      view
      |> upload(@filename)
      |> form("#upload-form", %{album: %{name: "this is a test"}})
      |> render_submit
      |> follow_redirect(conn)

    assert has_element?(next_view, "h2", "this is a test")
    assert has_element?(next_view, "[data-role=image]")
  end

  defp upload(view, filename) do
    photos = [
      %{
        name: filename,
        content: File.read!("test/support/images/#{filename}"),
        type: "image/png"
      }
    ]

    view
    |> file_input("#upload-form", :photos, photos)
    |> render_upload(filename)

    view
    |> form("#upload-form")
    |> render_change

    view
  end

  defp cancel_upload(view) do
    view
    |> element("[data-role=cancel-upload]")
    |> render_click
  end
end
