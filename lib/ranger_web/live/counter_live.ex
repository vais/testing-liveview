defmodule RangerWeb.CounterLive do
  use RangerWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def render(assigns) do
    ~H"""
    <button id="decrement" phx-click="decrement">decrement</button>
    <span id="count"><%= @count %></span>
    <button id="increment" phx-click="increment">increment</button>
    """
  end

  def handle_event("increment", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("decrement", _, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end
end
