----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit;            use AUnit;
with AUnit.Test_Cases; use AUnit.Test_Cases;

package Dynamical_Time_Tests is

   type Dynamical_Time_Test_Case is new Test_Case with null record;

   overriding function Name
      (T : Dynamical_Time_Test_Case) return Message_String;

   overriding procedure Set_Up
      (T : in out Dynamical_Time_Test_Case);

   overriding procedure Register_Tests
      (T : in out Dynamical_Time_Test_Case);

   --  Test routines

   procedure Test_TT (T : in out Test_Case'Class);
   procedure Test_TU (T : in out Test_Case'Class);
   procedure Test_TDB (T : in out Test_Case'Class);

end Dynamical_Time_Tests;