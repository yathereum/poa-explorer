defmodule ExplorerWeb.ExplorerChannelTest do
  use ExplorerWeb.ChannelCase

  describe "user_explorer channel tests" do
    test "subscribed user can receive channel message" do
      channel = "user_explorer"
      @endpoint.subscribe(channel)

      ExplorerWeb.Endpoint.broadcast(channel, "new_transaction", %{body: "test"})

      receive do
        %Phoenix.Socket.Broadcast{
          event: "new_transaction",
          topic: ^channel,
          payload: %{body: body}} ->
            assert body == "test"
      after
        5_000 ->
          assert false, "Expected message received nothing."
      end
    end
  end
end
