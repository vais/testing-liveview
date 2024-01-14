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

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    socket
    |> cancel_upload(:photos, ref)
    |> noreply
  end

  def render(assigns) do
    ~H"""
    <.form phx-change="validate" id="upload-form" for={%{}}>
      <.live_file_input upload={@uploads.photos} />
    </.form>

    <figure :for={entry <- @uploads.photos.entries} class="flex flex-col">
      <button
        type="button"
        data-role="cancel-upload"
        phx-click="cancel-upload"
        phx-value-ref={entry.ref}
        class="self-end"
      >
        &times;
      </button>
      <.live_img_preview entry={entry} data-role="image-preview" data-name={entry.client_name} />
    </figure>
    """
  end
end
