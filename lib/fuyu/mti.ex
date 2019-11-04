defmodule Fuyu.Message.MTI do
  defstruct [:iso_version, :message_class, :message_function, :message_origin]

  def new(raw) do
    <<iso_version::binary-size(1), _rest::binary>> = raw

    %__MODULE__{
      iso_version: iso_version(iso_version)
    }
  end

  defp iso_version(byte) do
    case byte do
      "0" -> 1987
      "1" -> 1993
      "2" -> 2003
      reserved when reserved in ["3", "4", "5", "6", "7"] -> :reserved
      "8" -> :national_use
      "9" -> :private_use
    end
  end
end
