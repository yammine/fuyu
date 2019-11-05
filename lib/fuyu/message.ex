defmodule Fuyu.Message do
  defstruct [:mti]

  alias Fuyu.Message.MTI

  def new(raw) do
    <<
      mti_raw::binary-size(4),
      _rest::binary
    >> = raw

    %__MODULE__{
      mti: MTI.new(mti_raw)
    }
  end
end
