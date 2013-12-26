Dynamo.under_test(Wdcboard.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule Wdcboard.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
