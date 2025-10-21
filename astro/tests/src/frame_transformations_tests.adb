-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit.Assertions; use AUnit.Assertions;

with Astro.Generic_Frame_Transformations;

package body Frame_Transformations_Tests is

   ---------------
   -- Framework --
   ---------------

   type Real is new Long_Long_Float;

   package Frame_Transformations is
     new Astro.Generic_Frame_Transformations (Real);

   use Frame_Transformations;
   use Julian_Time; -- instantiated in Frame_Transformations

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Frame_Transformations_Test_Case) return Message_String is
   begin
      return Format ("Frame_Transformation tests");
   end Name;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests
      (T : in out Frame_Transformations_Test_Case) is
      use Test_Cases.Registration;
   begin
      Register_Routine
         (T, Test_Correct_Light_Deflection'Access,
            "Correct light deflection - not implemented");
      Register_Routine
         (T, Test_Correct_Aberration'Access,
            "Correct aberration - not implemented");
      Register_Routine
         (T, Test_Precess'Access, "Precess - not implemented");
      Register_Routine
         (T, Test_Nutate'Access, "Nutate  - not implemented");
      Register_Routine
         (T, Test_Get_Nutation_Angles'Access, "Get Nutation Angles");
   end Register_Tests;

   ------------------------
   -- Auxiliary function --
   ------------------------

   --  Compare real values
   function Equals (X, Y : Real; Error : Real := 1.0E-6) return Boolean is
   begin
      return abs (X - Y) <= Error;
   end Equals;

   -------------------
   -- Test routines --
   -------------------

   --  Test correct Aberration
   --  not implemented

   procedure Test_Correct_Aberration (T : in out Test_Case'Class) is
   begin
      null;
   end Test_Correct_Aberration;

   --  Test Correct Light Deflection
   --  not implemented

   procedure Test_Correct_Light_Deflection (T : in out Test_Case'Class) is
   begin
      null;
   end Test_Correct_Light_Deflection;

   --  Test Precess
   --  not implemented

   procedure Test_Precess (T : in out Test_Case'Class) is
   begin
      null;
   end Test_Precess;

   --  Test_Nutate  --
   --  not implemented

   procedure Test_Nutate (T : in out Test_Case'Class) is
   begin
      null;
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

end Frame_Transformations_Tests;