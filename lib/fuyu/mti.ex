defmodule Fuyu.Message.MTI do
  defstruct [:iso_version, :message_class, :message_function, :message_origin]

  @type t :: %__MODULE__{
    iso_version: 1987 | 1993 | 2003 | :reserved | :national_use | :private_use,
    message_class: Atom.t,
    message_function: Atom.t,
    message_origin: Atom.t
  }

  def new(raw) do
    <<
      iso_version::binary-size(1),
      message_class::binary-size(1),
      message_function::binary-size(1),
      message_origin::binary-size(1),
    >> = raw

    %__MODULE__{
      iso_version: map_iso_version(iso_version),
      message_class: map_message_class(message_class, message_origin),
      message_function: map_message_function(message_function),
      message_origin: map_message_origin(message_origin)
    }
  end

  @version_reserved ~w(3 4 5 6 7)

  defp map_iso_version(version_byte) do
    case version_byte do
      "0" -> 1987
      "1" -> 1993
      "2" -> 2003
      "8" -> :national_use
      "9" -> :private_use
      version when version in @version_reserved -> :reserved
    end
  end

  defp map_message_class(_class_byte = "4", _origin_byte = "0"), do: :reversal
  defp map_message_class(_class_byte = "4", _origin_byte = "1"), do: :reversal

  defp map_message_class(_class_byte = "4", _origin_byte = "2"), do: :chargeback
  defp map_message_class(_class_byte = "4", _origin_byte = "3"), do: :chargeback

  defp map_message_class(class_byte, _irrelevant_origin_byte) do
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
    end
  end

  defp map_message_function(function_byte) do
    case function_byte do
      "0" -> :request
      "1" -> :response
      "2" -> :advice
      "3" -> :advice_response
      "4" -> :notification
      "5" -> :notification_ack
      # ISO 8583:2003
      "6" -> :instruction
      "7" -> :instruction_ack
      # Reserved (Some implementations like MasterCard use for positive/negative acknowledgement)
      "8" -> :reserved
      "9" -> :reserved
    end
  end

  @origin_reserved ~w(6 7 8 9)

  defp map_message_origin(origin_byte) do
    case origin_byte do
      "0" -> :acquirer
      "1" -> :acquirer_repeat
      "2" -> :issuer
      "3" -> :issuer_repeat
      "4" -> :other
      "5" -> :other_repeat
      origin when origin in @origin_reserved -> :reserved
    end
  end
end
