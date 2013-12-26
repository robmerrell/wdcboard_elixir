defmodule CoinPriceUpdaterTest do
  import Mock
  use Wdcboard.TestCase
  alias Wdcboard.Updaters.CoinPrice

  test "Returns a floating point USD value for one BTC" do
    res = HTTPotion.Response.new(status_code: 200, body: '{"btc_to_usd":"676.58046"}')

    with_mock HTTPotion, [get: fn(_url) ->  res end] do
      assert CoinPrice.coinbase_quote() == 676.58046
    end
  end

  test "Returns a floating point WDC/BTC value" do
    res = HTTPotion.Response.new(status_code: 200, body: '{\"success\": 1, \"return\": {\"markets\": {\"WDC\": {\"recenttrades\": [{\"id\": \"9496223\", \"time\": \"2013-12-25 16:27:42\", \"price\": \"0.00053275\", \"quantity\": \"32.67455654\", \"total\": \"0.01740737\"}]}}}}')

    with_mock HTTPotion, [get: fn(_url) ->  res end] do
      assert CoinPrice.cryptsy_quote() == 0.00053275
    end
  end

end
