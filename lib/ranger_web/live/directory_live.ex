defmodule RangerWeb.DirectoryLive do
  use RangerWeb, :live_view

  alias Ranger.Directory

  def mount(_params, _session, socket) do
    members = Directory.all_members()
    active_member = hd(members)
    socket = assign(socket, members: members, active_member: active_member)
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _, socket) do
    active_member = Directory.find_by(id: String.to_integer(id))
    socket = assign(socket, active_member: active_member)
    {:noreply, socket}
  end

  def handle_params(_, _, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <.link :for={member <- @members} data-role="member" patch={~p"/directory/#{member.id}"}>
      <%= member.name %>
    </.link>

    <div id="active-member">
      <%= @active_member.name %>
    </div>
    """
  end
end
