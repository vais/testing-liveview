defmodule RangerWeb.TodoLiveTest do
  use RangerWeb.ConnCase
  import Phoenix.LiveViewTest

  test "user can add a new todo", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/todo")

    todos = ["Buy milk", "???", "Profit!"]

    for body <- todos do
      view
      |> form("#add-todo", %{todo: %{body: body}})
      |> render_submit()
    end

    for body <- todos do
      assert has_element?(view, "[data-role=todo]", body)
    end
  end
end
