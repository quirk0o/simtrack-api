defmodule SimTribeWeb.TraitLiveTest do
  use SimTribeWeb.ConnCase

  import Phoenix.LiveViewTest
  import SimTribe.TraitsFixtures

  @create_attrs %{name: "some name", type: "some type", description: "some description", img_url: "some img_url", life_stages: ["option1", "option2"], external_id: "some external_id", external_source: "some external_source", archived: true}
  @update_attrs %{name: "some updated name", type: "some updated type", description: "some updated description", img_url: "some updated img_url", life_stages: ["option1"], external_id: "some updated external_id", external_source: "some updated external_source", archived: false}
  @invalid_attrs %{name: nil, type: nil, description: nil, img_url: nil, life_stages: [], external_id: nil, external_source: nil, archived: false}

  defp create_trait(_) do
    trait = trait_fixture()
    %{trait: trait}
  end

  describe "Index" do
    setup [:create_trait]

    test "lists all traits", %{conn: conn, trait: trait} do
      {:ok, _index_live, html} = live(conn, ~p"/admin/traits")

      assert html =~ "Listing Traits"
      assert html =~ trait.name
    end

    test "saves new trait", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/traits")

      assert index_live |> element("a", "New Trait") |> render_click() =~
               "New Trait"

      assert_patch(index_live, ~p"/admin/traits/new")

      assert index_live
             |> form("#trait-form", trait: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#trait-form", trait: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/admin/traits")

      html = render(index_live)
      assert html =~ "Trait created successfully"
      assert html =~ "some name"
    end

    test "updates trait in listing", %{conn: conn, trait: trait} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/traits")

      assert index_live |> element("#traits-#{trait.id} a", "Edit") |> render_click() =~
               "Edit Trait"

      assert_patch(index_live, ~p"/admin/traits/#{trait}/edit")

      assert index_live
             |> form("#trait-form", trait: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#trait-form", trait: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/admin/traits")

      html = render(index_live)
      assert html =~ "Trait updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes trait in listing", %{conn: conn, trait: trait} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/traits")

      assert index_live |> element("#traits-#{trait.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#traits-#{trait.id}")
    end
  end

  describe "Show" do
    setup [:create_trait]

    test "displays trait", %{conn: conn, trait: trait} do
      {:ok, _show_live, html} = live(conn, ~p"/admin/traits/#{trait}")

      assert html =~ "Show Trait"
      assert html =~ trait.name
    end

    test "updates trait within modal", %{conn: conn, trait: trait} do
      {:ok, show_live, _html} = live(conn, ~p"/admin/traits/#{trait}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Trait"

      assert_patch(show_live, ~p"/admin/traits/#{trait}/show/edit")

      assert show_live
             |> form("#trait-form", trait: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#trait-form", trait: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/admin/traits/#{trait}")

      html = render(show_live)
      assert html =~ "Trait updated successfully"
      assert html =~ "some updated name"
    end
  end
end
