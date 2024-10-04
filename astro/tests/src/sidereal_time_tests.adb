-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

with AUnit.Assertions; use AUnit.Assertions;

with Astro.Generic_Julian_Time;
with Astro.Generic_Sidereal_Time;
with Astro.Generic_Frame_Transformations;

package body Sidereal_Time_Tests is

   type Real is new Long_Long_Float;

   package Real_Functions is
      new Ada.Numerics.Generic_Elementary_Functions (Real);

   package Real_Arrays is
     new Ada.Numerics.Generic_Real_Arrays (Real);

   package Julian_Time is
     new Astro.Generic_Julian_Time (Real);

   package Frame_Transformations is
      new Astro.Generic_Frame_Transformations
       (Real, Real_Functions, Real_Arrays, Julian_Time);

   package Sidereal_Time is
      new Astro.Generic_Sidereal_Time
         (Real, Real_Functions, Real_Arrays, Julian_Time,
          Frame_Transformations);

   use Julian_Time;
   use Sidereal_Time;

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Sidereal_Time_Test_Case) return Message_String is
   begin
      return Format ("Sidereal_Time tests");
   end Name;

   ------------
   -- Set_Up --
   ------------

   Max_Error : constant Real := 0.1;

   JD1, JD2, JD3         : Date;
   GMST1, GMST2, GMST3   : Time;
   GAST1, GAST2, GAST3   : Time;

   overriding procedure Set_Up
      (T : in out Sidereal_Time_Test_Case) is
   begin
      JD1   := 2_460_587.0;   -- 2024.10.03 12:00:00
      GMST1 := 46_244.1871;   -- 12:50:44.1871
      GAST1 := 46_244.0267;   -- 12:50:44.0267

      JD2   := 2_458_849.5;   -- 2020.01.01 00:00:00
      GMST2 := 24_029.2343;   -- 06:40:29.2343
      GAST2 := 24_028.2256;   -- 06:40:28.2256

      JD3   := 2_462_683.25;  -- 2030.06.30 18:00:00
      GMST3 := 45_323.379;    -- 12:35:23.3790
      GAST3 := 45_324.431;    -- 12:35:24.4310
   end Set_Up;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests (T : in out Sidereal_Time_Test_Case) is
      use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_GMST'Access, "GMST");
      Register_Routine
        (T, Test_GAST'Access, "GAST");
   end Register_Tests;

   --------------------
   --  Test routines --
   --------------------

   --  Compare time values  --

   function Equals (X, Y : Time) return Boolean is
   begin
      return abs (X - Y) <= Max_Error;
   end Equals;

   --  Test_GMST  --

   procedure Test_GMST (T : in out Test_Case'Class) is
   begin
      Assert (Equals (GMST (JD1), GMST1), "Incorrect GMST calculation");
      Assert (Equals (GMST (JD2), GMST2), "Incorrect GMST calculation");
      Assert (Equals (GMST (JD3), GMST3), "Incorrect GMST calculation");
   end Test_GMST;

   --  Test GAST  --

   procedure Test_GAST  (T : in out Test_Case'Class) is
   begin
      Assert (Equals (GAST (JD1), GAST1), "Incorrect GAST calculation");
      Assert (Equals (GAST (JD2), GAST2), "Incorrect GAST calculation");
      Assert (Equals (GAST (JD3), GAST3), "Incorrect GAST calculation");
   end Test_GAST;

end Sidereal_Time_Tests;