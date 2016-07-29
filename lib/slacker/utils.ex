defmodule Slacker.Utils do
  require IEx

  @timezone Application.get_env(:slacker, :default_timezone, "America/Detroit")
  @office_start Application.get_env(:slacker, :office_start, 8)
  @office_end Application.get_env(:slacker, :office_end, 5)

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

  def office_hours do
    now = Timex.now(@timezone)
    midnight = Timex.beginning_of_day(now)

    office_start = Timex.shift(midnight, hours: @office_start)
    office_end = Timex.shift(midnight, hours: @office_end)

    Timex.between?(now, office_start, office_end)
  end
end
