defmodule RangerWeb.NewsletterLive do
  use RangerWeb, :live_view

  alias Ranger.Newsletter

  def mount(_params, _session, socket) do
    form = to_form(Newsletter.new_subscription())
    socket = assign(socket, :form, form)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.simple_form for={@form} phx-change="validate">
      <.input field={@form[:email]} autofocus="true" phx-debounce />
      <span data-role="subscribe-message" class="text-sm text-gray-500">
        No spam ever. Unsubscribe any time!
      </span>
      <:actions>
        <.button>Subscribe</.button>
      </:actions>
    </.simple_form>
    """
  end

  def handle_event("validate", %{"subscription" => params}, socket) do
    form =
      params
      |> Newsletter.new_subscription()
      |> Map.put(:action, :insert)
      |> to_form()

    socket = assign(socket, :form, form)
    {:noreply, socket}
  end
end
