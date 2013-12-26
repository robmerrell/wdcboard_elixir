defmodule Mix.Tasks.Wdc.Updaters do
  alias Wdcboard.Updaters.CoinPrice

  defmodule Price do
    use Mix.Task
    @shortdoc "Get updated BTC/USD and WCD/BTC prices and save them to the database"

    def run(_) do
      HTTPotion.start
      btc = CoinPrice.coinbase_quote()
      wdc = CoinPrice.cryptsy_quote()

      IO.puts btc
      IO.puts wdc
    end
  end
  
end
