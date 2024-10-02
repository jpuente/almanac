-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

with Ada.Text_IO;

with AUnit.Assertions; use AUnit.Assertions;

with Astro.Generic_Julian_Time;
with Astro.Generic_Sidereal_Time;
with Astro.Generic_Frame_Transformations;

package body Sidereal_Time_Tests is

   type Real is new Long_Float;

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

   D0 : Date;
   T0, T1, T2 : Time;

   overriding procedure Set_Up
      (T : in out Sidereal_Time_Test_Case) is
   begin
      D0 := 2_451_545.0;  -- J2000.0 = 2000.01.01 12:00:00
      T0 := 67311.0;      -- GST 18:41:51   
      T1 := 67309.6974;   -- GAST 18:41:49.6974
      T2 := 67310.5494;   -- GMST 18:41:50.5494
   end Set_Up;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests (T : in out Sidereal_Time_Test_Case) is
      use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_GMST'Access, "GMST calculation");
      Register_Routine
        (T, Test_GST'Access, "GAST calculation");
   end Register_Tests;

   --------------------
   --  Test routines --
   --------------------

   function Absolute_Error (X, Y : Time) return Real is
      Z : Real;
   begin
      Z := Abs (X - Y);
      Ada.Text_IO.Put_Line (">>> " & X'Image & "---" & Y'Image & "---" & Z'Image);
      return Abs (X - Y);
   end Absolute_Error;

   procedure Test_GMST (T : in out Test_Case'Class) is
   begin
      Assert (Absolute_Error(GMST(D0), T2) <= 1.0E-3, "GMST calculation is incorrect");
   end Test_GMST;

   procedure Test_GST  (T : in out Test_Case'Class) is
   begin
      Assert (Absolute_Error(GST (D0), T1) <= 1.0E-3, "GAST calculation is incorrect");
   end Test_GST;

end Sidereal_Time_Tests;