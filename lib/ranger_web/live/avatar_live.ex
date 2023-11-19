defmodule RangerWeb.AvatarLive do
  use RangerWeb, :live_view

  def mount(params, _session, socket) do
    email = params["email"]
    avatar_url = Ranger.Gravatar.generate_url(email)
    {:ok, assign(socket, email: email, avatar_url: avatar_url)}
  end

  def render(assigns) do
    ~H"""
    <img class="avatar" src={@avatar_url} alt={@email} />
    """
  end
end
