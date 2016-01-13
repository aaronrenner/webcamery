defmodule Webcamery.IntegrationCase do
  @moduledoc """
  This module defines the test case to be used by
  hound integration tests.

  If the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use ExUnit.Case
      use Hound.Helpers

      alias Webcamery.Repo
      import Ecto.Model
      import Ecto.Query, only: [from: 2]

      import Webcamery.Router.Helpers
      import Webcamery.TestHelpers

      hound_session
    end
  end

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(Webcamery.Repo, [])
    end

    :ok
  end
end
