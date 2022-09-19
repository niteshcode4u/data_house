defmodule DataHouseWeb.DataView do
  use DataHouseWeb, :view

  def render("data.json", %{results: results, topic: topic}) do
    %{"#{topic}" => render_many(results, __MODULE__, "#{topic}.json")}
  end

  def render("memes.json", %{data: meme}), do: meme
  def render("twitchdata.json", %{data: channel}), do: channel
  def render("dielectrons.json", %{data: dielectron}), do: dielectron
end
