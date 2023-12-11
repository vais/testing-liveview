defmodule RangerWeb.AboutLive do
  use RangerWeb, :live_view
  alias Ranger.FellowshipMember
  import RangerWeb.AboutComponents

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :members, FellowshipMember.characters())}
  end

  def render(assigns) do
    ~H"""
    <div class="grid grid-cols-2 gap-3">
      <.card :for={member <- @members}>
        <:header>
          <.title text={member.name} />
          <.badge type={member.type} />
        </:header>
        <%= member.description %>
      </.card>
    </div>
    """
  end
end
