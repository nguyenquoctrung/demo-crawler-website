defmodule DemoCrawlingWeb.PageController do
  use DemoCrawlingWeb, :controller
  @url "https://shopee.vn/api/v4/search/search_items?by=pop&limit=30&match_id=88201679&newest=0&order=desc&page_type=shop&scenario=PAGE_OTHERS&version=2"
  def index(conn, _params) do
    items = DemoCrawler.fetch(@url)
    render(conn, "index.html", data: items)
  end
end
