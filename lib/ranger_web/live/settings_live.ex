defmodule RangerWeb.SettingsLive do
  use RangerWeb, :live_view

  alias Ranger.Repo
  alias Ranger.User
  alias RangerWeb.SettingsLive.EditableInputComponent

  def mount(params, _session, socket) do
    user = Repo.get!(User, params["user_id"])

    form =
      user
      |> User.changeset(%{})
      |> to_form

    {:ok, assign(socket, user: user, form: form)}
  end

  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <.live_component module={EditableInputComponent} id="name" form={@form} field={:name} />
      <.live_component module={EditableInputComponent} id="email" form={@form} field={:email} />
    </div>
    """
  end

  def handle_info({:editable_input_component_save, params}, socket) do
    user =
      socket.assigns.user
      |> User.changeset(params["user"])
      |> Repo.update!()

    form =
      user
      |> User.changeset(%{})
      |> to_form

    {:noreply, assign(socket, user: user, form: form)}
  end
end
