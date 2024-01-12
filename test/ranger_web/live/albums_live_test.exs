defmodule RangerWeb.AlbumsLiveTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  @filename "apple.png"

  test "previewing uploads", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    view
    |> file_input("#upload-form", :photos, [
      %{
        name: @filename,
        content: File.read!("test/support/images/#{@filename}"),
        type: "image/png"
      }
    ])
    |> render_upload(@filename)

    view
    |> form("#upload-form")
    |> render_change()

    assert has_element?(view, ~s([data-role=image-preview][data-name="#{@filename}"]))
  end
end
