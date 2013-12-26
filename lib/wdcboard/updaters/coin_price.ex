defmodule Wdcboard.Updaters.CoinPrice do
  @moduledoc "Handles making the needed API calls to get pricing information about WDC."

  @coinbase_url "https://coinbase.com/api/v1/currencies/exchange_rates"
  @cryptsy_url "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=14"

  @doc "Get the current USD value for 1 BTC from coinbase.com"
  def coinbase_quote() do
    picker = fn (json) ->
      json["btc_to_usd"]
    end

    api_call @coinbase_url, picker
  end

  @doc "Get the current WDC/BTC value from cryptsy.com"
  def cryptsy_quote() do
    picker = fn (json) ->
      [latest_trade|_] = json["return"]["markets"]["WDC"]["recenttrades"]
      latest_trade["price"]
    end

    api_call @cryptsy_url, picker
  end

  # make a get request to the url. value_picker_func is a function that is expected
  # to receive a HashDict and return a float.
  defp api_call(url, value_picker_func) when is_function(value_picker_func, 1) do
    res = HTTPotion.get url

    if res.success? do
      {:ok, decoded} = JSON.decode res.body
      {parsed, _} = Float.parse value_picker_func.(decoded)
      parsed
    else
      0.0
    end
  end

end
