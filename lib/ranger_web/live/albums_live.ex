defmodule RangerWeb.AlbumsLive do
  use RangerWeb, :live_view

  def mount(_params, _session, socket) do
    socket
    |> allow_upload(:photos, accept: ~w(.png .jpg .jpeg), max_entries: 3)
    |> ok
  end

  def handle_event("validate", _params, socket) do
    socket
    |> noreply
  end

  def render(assigns) do
    ~H"""
    <.form phx-change="validate" id="upload-form" for={%{}}>
      <.live_file_input upload={@uploads.photos} />
    </.form>

    <.live_img_preview
      :for={entry <- @uploads.photos.entries}
      entry={entry}
      data-role="image-preview"
      data-name={entry.client_name}
    />
    """
  end
end
