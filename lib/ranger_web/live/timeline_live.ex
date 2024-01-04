defmodule RangerWeb.TimelineLive do
  alias Ranger.Timeline
  use RangerWeb, :live_view

  def mount(_params, _session, socket) do
    limit = 10
    offset = 0
    posts = Timeline.posts(limit: limit, offset: offset)

    socket =
      socket
      |> assign(limit: limit, offset: offset)
      |> stream(:posts, posts)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <ol phx-update="stream" id="posts" class="list-decimal">
      <li :for={{id, post} <- @streams.posts} id={id}>
        <div data-role="post"><%= post.text %></div>
        <div data-role="author"><%= post.author %></div>
      </li>
    </ol>
    <div id="loading" phx-hook="InfiniteScroll">Loading...</div>
    """
  end

  def handle_event("load-more", _params, socket) do
    limit = socket.assigns.limit
    offset = socket.assigns.offset + limit

    posts = Timeline.posts(limit: limit, offset: offset)

    socket =
      socket
      |> assign(offset: offset)
      |> stream_posts(posts)

    {:noreply, socket}
  end

  defp stream_posts(socket, posts) do
    Enum.reduce(posts, socket, fn post, socket ->
      stream_insert(socket, :posts, post)
    end)
  end
end
