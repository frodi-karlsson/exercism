defmodule Newsletter do
  def read_emails(path) do
    with {:ok, emails} <- File.read(path) do
      emails
      |> String.split("\n")
      |> Enum.filter(&(&1 != ""))
    end
  end

  def open_log(path) do
    with {:ok, pid} <- File.open(path, [:write]), do: pid
  end

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    case open_log(log_path) do
      pid when is_pid(pid) ->
        case read_emails(emails_path) do
          emails when is_list(emails) ->
            Enum.each(emails, &if(send_fun.(&1) == :ok, do: log_sent_email(pid, &1)))
          _ -> :ok
        end

        close_log(pid)

      {:error, _} = error -> error
    end
  end
end
