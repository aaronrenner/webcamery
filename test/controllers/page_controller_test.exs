defmodule Webcamery.PageControllerTest do
  use Webcamery.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hi Brad!"
  end
end
