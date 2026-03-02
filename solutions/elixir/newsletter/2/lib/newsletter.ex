defmodule Newsletter do
  def read_emails(path) do
    with {:ok, emails} <- File.read(path) do
      emails
      |> String.split("\n")
      |> Enum.filter(&(&1 != ""))
    end
  end

  def open_log(path), do: File.open!(path, [:write])

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)

    case read_emails(emails_path) do
      emails when is_list(emails) ->
        Enum.each(emails, &if(send_fun.(&1) == :ok, do: log_sent_email(pid, &1)))

      _ ->
        :ok
    end

    close_log(pid)
  end
end
