-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

with AUnit.Assertions; use AUnit.Assertions;

with Astro.Generic_Julian_Time;
with Astro.Generic_Frame_Transformations;

package body Frame_Transformations_Tests is

   ---------------
   -- Framework --
   ---------------

   type Real is new Long_Long_Float;

   package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);

   package Real_Arrays is
     new Ada.Numerics.Generic_Real_Arrays (Real);
   use Real_Arrays;

   package Julian_Time is
     new Astro.Generic_Julian_Time (Real);
   use Julian_Time;

   package Frame_Transformations is
     new Astro.Generic_Frame_Transformations
      (Real, Real_Functions, Real_Arrays, Julian_Time);
   use Frame_Transformations;

   ----------------------
   -- Fixture elements --
   ----------------------

   P, Q, E : Real_Vector (1 .. 3);

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Frame_Transformations_Test_Case) return Message_String is
   begin
      return Format ("Frame_Transformation tests");
   end Name;

   -----------
   -- Setup --
   -----------

   overriding procedure Set_Up
      (T : in out Frame_Transformations_Test_Case) is
   begin

      P := (0.0, 1.0, 0.0);
      Q := (0.7, 0.7, 0.0);
      E := (1.0, 0.0, 0.0);

   end Set_Up;

   -------------------
   -- Test routines --
   -------------------

   --  Compare real values  --

   function Equals (X, Y : Real; Error : Real := 1.0E-6) return Boolean is
   begin
      return abs (X - Y) <= Error;
   end Equals;

   procedure Test_Correct_Light_Deflection (T : in out Test_Case'Class) is
   begin
      Correct_Light_Deflection (P, Q, E);
      Assert (False, "test not implemented");
   end Test_Correct_Light_Deflection;

   procedure Test_Correct_Aberration (T : in out Test_Case'Class) is
   begin
      Assert (False, "test not implemented");
   end Test_Correct_Aberration;

   --  Test Precess

   procedure Test_Precess (T : in out Test_Case'Class) is
   begin
      Assert (False, "test not implemented");
   end Test_Precess;

   --  Test_Nutate  --

   procedure Test_Nutate (T : in out Test_Case'Class) is
   begin
      Assert (False, "test not implemented");
   end Test_Nutate;

   --  Test_Get_Nutation_Angles  --

   procedure Test_Get_Nutation_Angles (T : in out Test_Case'Class) is

      DPSI, DEPS : Real;

      JD1   : constant Date :=  2_460_587.0;     --  2024.10.03 12:00:00
      DPSI1 : constant Real := -0.000666666666;  --  -2.4"
      DEPS1 : constant Real :=  0.002666666667;  --   9.6"

      Max_Error : constant Real := 1.0E-4;       --   0,36"

   begin
      Get_Nutation_Angles (JD1, DPSI, DEPS);
      Assert (Equals (DPSI, DPSI1, Max_Error),
         "Incorrect Delta_Psi" & DPSI'Image);
      Assert (Equals (DEPS, DEPS1, Max_Error),
         "Incorrect Delta_Eps" & DEPS'Image);
   end Test_Get_Nutation_Angles;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests
      (T : in out Frame_Transformations_Test_Case) is
      use Test_Cases.Registration;
   begin
      Register_Routine
         (T, Test_Correct_Light_Deflection'Access, "Correct light deflection");
      Register_Routine
         (T, Test_Correct_Aberration'Access, "Correct aberration");
      Register_Routine
         (T, Test_Precess'Access, "Precess");
      Register_Routine
         (T, Test_Nutate'Access, "Nutate");
      Register_Routine
         (T, Test_Get_Nutation_Angles'Access, "Get Nutation Angles");

   end Register_Tests;

end Frame_Transformations_Tests;