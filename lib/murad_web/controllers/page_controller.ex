defmodule MuradWeb.PageController do
  use MuradWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
