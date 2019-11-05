defmodule Fuyu.Message.MTI do
  defstruct [:iso_version, :message_class, :message_function, :message_origin]

  def new(raw) do
    <<
      iso_version::binary-size(1),
      message_class::binary-size(1),
      _message_function::binary-size(1),
      message_origin::binary-size(1),
    >> = raw

    %__MODULE__{
      iso_version: iso_version(iso_version),
      message_class: message_class(message_class, message_origin)
    }
  end

  defp iso_version(version_byte) do
    case version_byte do
      "0" -> 1987
      "1" -> 1993
      "2" -> 2003
      "8" -> :national_use
      "9" -> :private_use
      version when version in ["3", "4", "5", "6", "7"] -> :reserved
    end
  end

  defp message_class(_class_byte = "4", _origin_byte = "0"), do: :reversal
  defp message_class(_class_byte = "4", _origin_byte = "1"), do: :reversal

  defp message_class(_class_byte = "4", _origin_byte = "2"), do: :chargeback
  defp message_class(_class_byte = "4", _origin_byte = "3"), do: :chargeback

  defp message_class(class_byte, _irrelevant_origin_byte) do
    case class_byte do
      "0" -> :reserved
      "1" -> :authorization
      "2" -> :financial
      "3" -> :file_actions
      "5" -> :reconciliation
      "6" -> :administrative
      "7" -> :fee_collection
      "8" -> :network_management
      "9" -> :reserved
      _ -> nil
    end
  end
end
