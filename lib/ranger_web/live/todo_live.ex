defmodule RangerWeb.TodoLive do
  use RangerWeb, :live_view

  alias Ranger.Repo
  alias Ranger.Todo

  def mount(_params, _session, socket) do
    form = to_form(Todo.changeset(%{}))
    todos = Repo.all(Todo)
    {:ok, socket |> assign(:form, form) |> stream(:todos, todos)}
  end

  def render(assigns) do
    ~H"""
    <ul id="todos" phx-update="stream">
      <li :for={{id, todo} <- @streams.todos} data-role="todo" id={id}><%= todo.body %></li>
    </ul>

    <.simple_form for={@form} id="add-todo" phx-submit="create">
      <.input field={@form[:body]} />
    </.simple_form>
    """
  end

  def handle_event("create", params, socket) do
    case create_todo(params["todo"]) do
      {:ok, todo} ->
        {:noreply, stream_insert(socket, :todos, todo)}
    end
  end

  defp create_todo(params) do
    params
    |> Todo.changeset()
    |> Repo.insert()
  end
end
