defmodule Fuyu.Message.MTITest do
  use ExUnit.Case
  alias Fuyu.Message.MTI

  describe "iso_version" do
    test "vesrion 1987" do
      raw = "0200"
      mti = MTI.new(raw)

      assert mti.iso_version == 1987
    end

    test "version 1993" do
      raw = "1200"
      mti = MTI.new(raw)

      assert mti.iso_version == 1993
    end

    test "version 2003" do
      raw = "2200"
      mti = MTI.new(raw)

      assert mti.iso_version == 2003
    end

    # Reserved by ISO
    for n <- 3..7 do
      test "reserved version #{n}" do
        raw = "#{unquote(n)}000"
        mti = MTI.new(raw)

        assert mti.iso_version == :reserved
      end
    end

    test "national use" do
      raw = "8000"
      mti = MTI.new(raw)

      assert mti.iso_version == :national_use
    end

    test "private use" do
      raw = "9000"
      mti = MTI.new(raw)

      assert mti.iso_version == :private_use
    end
  end

  describe "message_class" do
    test "reserved" do
      raw = "0010"
      mti = MTI.new(raw)

      assert mti.message_class == :reserved

      raw = "0910"
      mti = MTI.new(raw)

      assert mti.message_class == :reserved
    end

    test "authorization" do
      raw = "0100"
      mti = MTI.new(raw)

      assert mti.message_class == :authorization
    end

    test "financial" do
      raw = "0200"
      mti = MTI.new(raw)

      assert mti.message_class == :financial
    end

    test "file_actions" do
      raw = "0300"
      mti = MTI.new(raw)

      assert mti.message_class == :file_actions
    end

    test "reversal x4x0" do
      raw = "0400"
      mti = MTI.new(raw)

      assert mti.message_class == :reversal
    end

    test "reversal x4x1" do
      raw = "0401"
      mti = MTI.new(raw)

      assert mti.message_class == :reversal
    end

    test "chargeback x4x2" do
      raw = "0402"
      mti = MTI.new(raw)

      assert mti.message_class == :chargeback
    end

    test "chargeback x4x3" do
      raw = "0403"
      mti = MTI.new(raw)

      assert mti.message_class == :chargeback
    end
  end
end
