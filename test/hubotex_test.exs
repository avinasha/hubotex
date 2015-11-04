defmodule Hubotex.RobotTest do
  use ExUnit.Case

  setup do 
    {:ok, robot} = Hubotex.Robot.start_link([
      {~r/hello/, fn _msg -> "Hai there!" end},
      {~r/goodbye/, fn _msg -> "Oh! Dont leave!" end}
    ])
    
    {:ok, robot: robot}
  end
  
  test "Hubotex.Robot.accept/1 responds with the right message for \"hello\"" do
    assert Hubotex.Robot.accept("hello") == {:ok, "Hai there!"}
  end
  
  test "Hubotex.Robot.accept/1 responds with the right message for \"goodbye\"" do
    assert Hubotex.Robot.accept("goodbye") == {:ok, "Oh! Dont leave!"}
  end
  
  test "Hubotex.Robot.accept/1 responds with the right message for no match" do
    assert Hubotex.Robot.accept("nomatch") == {:nomatch, "nomatch"}
  end
end
