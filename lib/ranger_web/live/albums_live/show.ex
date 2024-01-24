defmodule RangerWeb.AlbumsLive.Show do
  use RangerWeb, :live_view

  alias Ranger.Album
  alias Ranger.Repo

  def mount(%{"id" => id}, _session, socket) do
    socket
    |> assign(:album, Repo.get!(Album, id))
    |> ok
  end

  def render(assigns) do
    ~H"""
    <h2><%= @album.name %></h2>
    <img :for={url <- @album.urls} data-role="image" src={url} />
    """
  end
end
