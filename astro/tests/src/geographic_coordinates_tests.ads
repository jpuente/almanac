-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit;            use AUnit;
with AUnit.Test_Cases; use AUnit.Test_Cases;

package Geographic_Coordinates_Tests is

   type Geographic_Coordinates_Test_Case is new Test_Case with null record;

   overriding function Name
      (T : Geographic_Coordinates_Test_Case) return Message_String;

   overriding procedure Set_Up
      (T : in out Geographic_Coordinates_Test_Case);

   overriding procedure Register_Tests
      (T : in out Geographic_Coordinates_Test_Case);

   --  Test routines

   procedure Test_Geocentric_Position (T : in out Test_Case'Class);

end Geographic_Coordinates_Tests;