defmodule RangerWeb.WeAreLive do
  use RangerWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :we_are_live, connected?(socket))}
  end

  def render(assigns) do
    ~H"""
    <%= if @we_are_live do %>
      <h1>Now we are cooking with gas!</h1>
    <% else %>
      <h1>Not connected yet</h1>
    <% end %>
    """
  end
end
