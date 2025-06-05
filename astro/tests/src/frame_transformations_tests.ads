-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with AUnit;            use AUnit;
with AUnit.Test_Cases; use AUnit.Test_Cases;

package Frame_Transformations_Tests is

   type Frame_Transformations_Test_Case is new Test_Case with null record;

   overriding function Name
      (T : Frame_Transformations_Test_Case) return Message_String;

   overriding procedure Set_Up
      (T : in out Frame_Transformations_Test_Case);

   overriding procedure Register_Tests
      (T : in out Frame_Transformations_Test_Case);

   --  Test routines

   procedure Test_Correct_Light_Deflection (T : in out Test_Case'Class);
   procedure Test_Correct_Aberration (T : in out Test_Case'Class);
   procedure Test_Precess (T : in out Test_Case'Class);
   procedure Test_Nutate (T : in out Test_Case'Class);
   procedure Test_Get_Nutation_Angles (T : in out Test_Case'Class);

end Frame_Transformations_Tests;
