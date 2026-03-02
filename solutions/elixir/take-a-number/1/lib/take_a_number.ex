defmodule TakeANumber do
  @initial_state 0
  def start(), do: spawn(fn -> loop(@initial_state) end)

  defp loop(state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        loop(state)

      {:take_a_number, sender_pid} ->
        next = state + 1
        send(sender_pid, next)
        loop(next)

      :stop ->
        :ok

      _ ->
        loop(state)
    end
  end
end
