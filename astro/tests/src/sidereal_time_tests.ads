-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with AUnit;            use AUnit;
with AUnit.Test_Cases; use AUnit.Test_Cases;

package Sidereal_Time_Tests is

   type Sidereal_Time_Test_Case is new Test_Case with null record;

   overriding function Name
      (T : Sidereal_Time_Test_Case) return Message_String;

   overriding procedure Set_Up
      (T : in out Sidereal_Time_Test_Case);

   overriding procedure Register_Tests
      (T : in out Sidereal_Time_Test_Case);

   --  Test routines

   procedure Test_GMST (T : in out Test_Case'Class);
   procedure Test_GAST (T : in out Test_Case'Class);

end Sidereal_Time_Tests;