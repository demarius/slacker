defmodule Slacker.Utils do
  require IEx

  @timezone Application.get_env(:slacker, :default_timezone, "America/Detroit")
  @day_start Application.get_env(:slacker, :day_start, 8)
  @day_end Application.get_env(:slacker, :day_end, 5)

  def my_channels(slack) do
    slack.channels
    |> Enum.filter(
      fn {_channel_id, channel_info} ->
        channel_info.is_member && !channel_info.is_archived
      end
    )
  end

  def get_user(user_id, slack) do
    slack.users
    |> Enum.find(fn {id, _user} -> user_id == id end)
  end

  def random_user(channel_id, slack) do
    {_channel_id, channel} = slack.channels
    |> Enum.find(fn {c_id, channel} -> c_id == channel_id end)

    if channel do
      channel.members
      |> Enum.map(fn user_id -> get_user(user_id, slack) end)
      |> Enum.filter(fn item -> item end)
      |> Enum.filter(fn {user_id, user} ->
          user.presence == 'active' && user.id != slack.me.id
        end)
      |> random
    else
      nil
    end
  end

  defp random(nil), do: nil
  defp random([]), do: nil
  defp random(list), do: Enum.random(list)

  def hours do
    now = Timex.now(@timezone)
    midnight = Timex.beginning_of_day(now)

    day_start = Timex.shift(midnight, hours: @day_start)
    day_end = Timex.shift(midnight, hours: @day_end)

    Timex.between?(now, day_start, day_end)
  end
end
