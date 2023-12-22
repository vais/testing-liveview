defmodule RangerWeb.SettingsLive.EditableInputComponent do
  use RangerWeb, :live_component

  def mount(socket) do
    {:ok, assign(socket, :editing, false)}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-md mx-auto">
      <%= if @editing do %>
        <.edit_field field={@field} form={@form} target={@myself} />
      <% else %>
        <.view_field field={@field} form={@form} target={@myself} />
      <% end %>
    </div>
    """
  end

  defp view_field(assigns) do
    ~H"""
    <div class="space-y-8 bg-white mt-10">
      <div
        id={@field}
        phx-click="edit"
        phx-target={@target}
        class="bg-gray-100 border-1 flex gap-6 hover:cursor-pointer items-center justify-between mt-2 p-2 rounded-lg text-sm"
      >
        <%= Map.get(@form.data, @field) %>
        <.icon name="hero-pencil-solid" class="w-4 h-4 stroke-current inline" />
      </div>
    </div>
    """
  end

  defp edit_field(assigns) do
    ~H"""
    <.simple_form
      id={"#{@field}-form"}
      for={@form}
      phx-target={@target}
      phx-submit="save"
      phx-click-away="cancel"
    >
      <.input field={@form[@field]} />
    </.simple_form>
    """
  end

  def handle_event("edit", _params, socket) do
    {:noreply, assign(socket, :editing, true)}
  end

  def handle_event("cancel", _params, socket) do
    {:noreply, assign(socket, :editing, false)}
  end

  def handle_event("save", params, socket) do
    send(self(), {:editable_input_component_save, params})
    {:noreply, assign(socket, :editing, false)}
  end
end
