defmodule Hubotex.RobotTest do
  use ExUnit.Case
  
  test "receive/1 responds with the right message for \"hello\"" do
    assert Hubotex.Robot.receive("hello") == {:ok, "Hai there!"}
  end
  
  test "receive/1 responds with the right message for \"goodbye\"" do
    assert Hubotex.Robot.receive("goodbye") == {:ok, "Oh! Dont leave!"}
  end
  
  test "receive/1 responds with the right message for no match" do
    assert Hubotex.Robot.receive("nomatch") == {:nomatch, "nomatch"}
  end
end
