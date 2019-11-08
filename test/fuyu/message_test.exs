defmodule Fuyu.MessageTest do
  use ExUnit.Case

  @example_iso8583v1987 "020042000400000000021612345678901234560609173030123456789ABC1000123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"

  describe "MTI - Message Type Indicator" do
  end

  describe "Primary Bitmap" do
    test "correctly decodes the bitmap" do
      message = Fuyu.Message.new(@example_iso8583v1987)

      # 4200040000000002 Hex -> 0100001000000000000001000000000000000000000000000000000000000010
      assert match?(<<66, 0, 4, 0, 0, 0, 0, 2>>, message.primary_bitmap)
    end

    test "builds a reversed list of set bit indices" do
      message = Fuyu.Message.new(@example_iso8583v1987)

      # The set bits should be [2, 7, 22, 63] (0100001000000000000001000000000000000000000000000000000000000010)
      assert match?([63, 22, 7, 2], message.included_fields)
    end
  end
end
