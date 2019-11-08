defmodule Fuyu.Message do
  defstruct [:mti, :primary_bitmap, :included_fields]

  alias Fuyu.Message.MTI

  def new(raw) do
    <<
      mti_raw::binary-size(4),
      # 16 Hexadecimal characters -> 64bit bitmap
      primary_bitmap_hex::binary-size(16),
      _rest::binary
    >> = raw

    primary_bitmap = Base.decode16!(primary_bitmap_hex)

    %__MODULE__{
      mti: MTI.new(mti_raw),
      primary_bitmap: primary_bitmap,
      included_fields: BinaryUtils.find_set_bits(primary_bitmap)
    }
  end
end
