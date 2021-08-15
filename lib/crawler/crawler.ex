defmodule DemoCrawler do
  def fetch(url) do
    response = Crawly.fetch(url)
    data = parse_item(response)
    data
  end

  defp parse_item(response) do
    {:ok, document} = Floki.parse_document(response.body)

    {:ok, results} = Poison.decode(document)

    case results["error"] do
      nil ->
        Enum.map(results["items"],
        fn item ->
          item_info = item["item_basic"]

          product_name = item_info["name"]

          image = item_info["image"]

          price = String.slice(Integer.to_string(item_info["price"]), 0..-6)

          sold = item_info["sold"]

          brand = item_info["brand"]

          price_before_discount = String.slice(Integer.to_string(item_info["price_before_discount"]), 0..-6)

          discount = item_info["discount"]

          currency=item_info["currency"]

          stock=item_info["stock"]

          shopid=item_info["shopid"]

          itemid=item_info["itemid"]


          %{
            "shopid"=>shopid,
            "itemid"=>itemid,
            "product_name" => product_name,
            "image" => "https://cf.shopee.vn/file/"<>image,
            "price" => price,
            "sold" => sold,
            "brand"=> brand,
            "price_before_discount" =>price_before_discount,
            "discount" =>discount,
            "currency" =>currency,
            "stock"=>stock
          }
        end)

      _ -> []
    end
  end
end
