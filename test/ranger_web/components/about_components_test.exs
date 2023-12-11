defmodule RangerWeb.AboutComponentsTest do
  use ExUnit.Case

  import Phoenix.LiveViewTest
  import Phoenix.Component, only: [sigil_H: 2]
  import RangerWeb.AboutComponents

  test "title" do
    html = render_component(&title/1, text: "hello")
    assert html =~ "hello"
  end

  describe "badge" do
    test "renders content" do
      assigns = %{}

      html =
        rendered_to_string(~H"""
        <.badge type="hobbit" />
        """)

      assert html =~ "hobbit"
    end

    test "renders green badge for a hobbit" do
      assert render_component(&badge/1, type: "hobbit") =~ "bg-green"
    end

    test "renders blue badge for a human" do
      assert render_component(&badge/1, type: "human") =~ "bg-blue"
    end

    test "renders yellow badge for a dwarf" do
      assert render_component(&badge/1, type: "dwarf") =~ "bg-yellow"
    end

    test "renders red badge for a wizard" do
      assert render_component(&badge/1, type: "wizard") =~ "bg-red"
    end

    test "renders gray badge for an elf" do
      assert render_component(&badge/1, type: "elf") =~ "bg-gray"
    end
  end

  describe "card" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <.card>
        <:header>hello</:header>
        ok bye
      </.card>
      """)

    assert html =~ "hello"
    assert html =~ "ok bye"
  end
end
