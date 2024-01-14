defmodule RangerWeb.AlbumsLiveTest do
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

  test "uploading too many files", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    view
    |> upload(@filename)
    |> upload(@filename)
    |> upload(@filename)
    |> upload(@filename)

    assert render(view) =~ "too_many_files"
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
