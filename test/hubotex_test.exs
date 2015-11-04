defmodule Hubotex.RobotTest do
  use ExUnit.Case

  setup do 
    {:ok, robot} = Hubotex.Robot.start_link([
      Hubotex.Rule.Hello.rule,
      Hubotex.Rule.Goodbye.rule
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
