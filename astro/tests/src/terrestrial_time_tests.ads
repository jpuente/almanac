-----------------------------------------------------------------------
--  Astro - Ada library for astronomical calculations.               --
--                                                                   --
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with AUnit;            use AUnit;
with AUnit.Test_Cases; use AUnit.Test_Cases;

package Terrestrial_Time_Tests is

   type Terrestrial_Time_Test_Case is new Test_Case with null record;

   overriding function Name
      (T : Terrestrial_Time_Test_Case) return Message_String;

   overriding procedure Set_Up
      (T : in out Terrestrial_Time_Test_Case);

   overriding procedure Register_Tests
      (T : in out Terrestrial_Time_Test_Case);

   --  Test routines

   procedure Test_UT1 (T : in out Test_Case'Class);
   procedure Test_TT  (T : in out Test_Case'Class);
   procedure Test_UTC (T : in out Test_Case'Class);

end Terrestrial_Time_Tests;
