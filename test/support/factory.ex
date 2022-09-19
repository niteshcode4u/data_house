defmodule DataHouse.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: DataHouse.Repo

  alias DataHouse.Schemas.Dielectron
  alias DataHouse.Schemas.Meme
  alias DataHouse.Schemas.TwitchData

  def dielectron_factory do
    %Dielectron{
      run: Faker.random_between(111_111, 999_999),
      event: Faker.random_between(111_111, 999_999),
      e1: Faker.Commerce.price(),
      px1: Faker.Commerce.price(),
      py1: Faker.Commerce.price(),
      pz1: -Faker.Commerce.price(),
      pt1: Faker.Commerce.price(),
      eta1: -Faker.Commerce.price(),
      phi1: Faker.Commerce.price(),
      q1: Faker.random_between(1, 999),
      e2: Faker.Commerce.price(),
      px2: -Faker.Commerce.price(),
      py2: Faker.Commerce.price(),
      pz2: -Faker.Commerce.price(),
      pt2: Faker.Commerce.price(),
      eta2: -Faker.Commerce.price(),
      phi2: Faker.Commerce.price(),
      q2: Faker.Commerce.price(),
      m: Faker.Commerce.price(),
      inserted_at: NaiveDateTime.utc_now(),
      updated_at: NaiveDateTime.utc_now()
    }
  end

  def meme_factory do
    %Meme{
      meme_id: Faker.String.base64(),
      archived_url: Faker.Internet.image_url(),
      base_meme_name: Faker.App.name(),
      meme_page_url: Faker.Internet.url(),
      md5_hash: Faker.UUID.v4(),
      file_size: Faker.random_between(111_111, 999_999),
      alt_text:
        "LEGS IN COVER. TOO HOT. LEGS OUT OF COVER. TOO cold. One leg out. Just right BUt Scared monster under the bed will eat me\n",
      inserted_at: NaiveDateTime.utc_now(),
      updated_at: NaiveDateTime.utc_now()
    }
  end

  def twitchdata_factory do
    %TwitchData{
      channel: Faker.String.base64(),
      watch_time: Faker.random_between(111_111, 999_999),
      stream_time: Faker.random_between(111_111, 999_999),
      peak_viewers: Faker.random_between(111_111, 999_999),
      avg_viewers: Faker.random_between(111_111, 999_999),
      followers: Faker.random_between(111_111, 999_999),
      followers_gained: Faker.random_between(111_111, 999_999),
      views_gained: Faker.random_between(111_111, 999_999),
      partnered: true,
      mature: false,
      language: Faker.String.base64(),
      inserted_at: NaiveDateTime.utc_now(),
      updated_at: NaiveDateTime.utc_now()
    }
  end
end
