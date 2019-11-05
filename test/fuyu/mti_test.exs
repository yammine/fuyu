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

    test "reconciliation" do
      raw = "0500"
      mti = MTI.new(raw)

      assert mti.message_class == :reconciliation
    end

    test "administrative" do
      raw = "0600"
      mti = MTI.new(raw)

      assert mti.message_class == :administrative
    end

    test "fee_collection" do
      raw = "0700"
      mti = MTI.new(raw)

      assert mti.message_class == :fee_collection
    end

    test "network_management" do
      raw = "0800"
      mti = MTI.new(raw)

      assert mti.message_class == :network_management
    end
  end

  describe "message_function" do
    test "request" do
      raw = "0001"
      mti = MTI.new(raw)

      assert mti.message_function == :request
    end

    test "response" do
      raw = "0011"
      mti = MTI.new(raw)

      assert mti.message_function == :response
    end

    test "advice" do
      raw = "0021"
      mti = MTI.new(raw)

      assert mti.message_function == :advice
    end

    test "advice_response" do
      raw = "0031"
      mti = MTI.new(raw)

      assert mti.message_function == :advice_response
    end

    test "notification" do
      raw = "0041"
      mti = MTI.new(raw)

      assert mti.message_function == :notification
    end

    test "notification_ack" do
      raw = "0051"
      mti = MTI.new(raw)

      assert mti.message_function == :notification_ack
    end

    test "instruction" do
      raw = "0061"
      mti = MTI.new(raw)

      assert mti.message_function == :instruction
    end

    test "instruction_ack" do
      raw = "0071"
      mti = MTI.new(raw)

      assert mti.message_function == :instruction_ack
    end

    test "reserved 8" do
      raw = "0081"
      mti = MTI.new(raw)

      assert mti.message_function == :reserved
    end

    test "reserved 9" do
      raw = "0091"
      mti = MTI.new(raw)

      assert mti.message_function == :reserved
    end
  end
end
