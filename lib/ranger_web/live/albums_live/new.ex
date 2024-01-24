defmodule RangerWeb.AlbumsLive.New do
  alias Ranger.Repo
  alias Ranger.Album
  use RangerWeb, :live_view

  def mount(_params, _session, socket) do
    album =
      %{}
      |> Album.changeset()
      |> to_form

    socket
    |> assign(:album, album)
    |> allow_upload(:photos, accept: ~w(.png .jpg .jpeg), max_entries: 3)
    |> ok
  end

  def handle_event("validate", %{"album" => params}, socket) do
    album =
      params
      |> Album.changeset()
      |> Map.put(:action, :validate)
      |> to_form

    socket
    |> assign(:album, album)
    |> noreply
  end

  def handle_event("save", %{"album" => params}, socket) do
    urls =
      consume_uploaded_entries(socket, :photos, fn %{path: _path}, entry ->
        {:ok, entry.client_name}
      end)

    params
    |> Map.put("urls", urls)
    |> Album.changeset()
    |> Repo.insert()
    |> then(fn
      {:ok, album} ->
        socket
        |> push_navigate(to: ~p"/albums/#{album}")

      {:error, changeset} ->
        socket
        |> assign(:album, to_form(changeset))
    end)
    |> noreply
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    socket
    |> cancel_upload(:photos, ref)
    |> noreply
  end

  def render(assigns) do
    ~H"""
    <.form phx-change="validate" phx-submit="save" id="upload-form" for={@album}>
      <.input field={@album[:name]} />
      <.live_file_input upload={@uploads.photos} />
    </.form>

    <p :for={err <- upload_errors(@uploads.photos)}><%= err %></p>

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
