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
end
