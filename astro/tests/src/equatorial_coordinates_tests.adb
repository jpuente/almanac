-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit.Assertions; use AUnit.Assertions;

with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

with Astro.Generic_Coordinates.Equatorial;

package body Equatorial_Coordinates_Tests is

   -----------------
   --  Framework  --
   -----------------

   type Real is new Long_Long_Float;

   package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);

   package Real_Arrays is
      new Ada.Numerics.Generic_Real_Arrays (Real);

   package Coordinates is
     new Astro.Generic_Coordinates
      (Real, Real_Functions, Real_Arrays);

   package Equatorial_Coordinates is
      new Coordinates.Equatorial;

   use Equatorial_Coordinates;

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Equatorial_Coordinates_Test_Case) return Message_String is
   begin
      return Format ("Equatorial_Coordinates tests");
   end Name;

   -----------
   -- Setup --
   -----------

   overriding procedure Set_Up
      (T : in out Equatorial_Coordinates_Test_Case) is
   begin
      null;
   end Set_Up;

   -------------------------
   -- Auxiliary function  --
   -------------------------

   function Equals (X, Y : Real; Error : Real := 1.0E-6) return Boolean is
   begin
      return abs (X - Y) <= Error;
   end Equals;

   -------------------
   -- Test routines --
   -------------------

   procedure Test_LHA (T : in out Test_Case'Class) is
   begin
      --  limit values
      Assert (LHA (GHA => 0.0, Longitude => 0.0) = 0.0, "invalid LHA");
      Assert (LHA (GHA => 0.0, Longitude => 90.0) = 90.0, "invalid LHA");
      Assert (LHA (GHA => 0.0, Longitude => 180.0) = 180.0, "invalid LHA");
      Assert (LHA (GHA => 0.0, Longitude => -90.0) = -90.0, "invalid LHA");
      Assert (LHA (GHA => 0.0, Longitude => -180.0) = -180.0, "invalid LHA");

      Assert (LHA (GHA => 90.0, Longitude => 0.0) = 90.0, "invalid LHA");
      Assert (LHA (GHA => 90.0, Longitude => 90.0) = 180.0, "invalid LHA");
      Assert (LHA (GHA => 90.0, Longitude => 180.0) = -90.0, "invalid LHA");
      Assert (LHA (GHA => 90.0, Longitude => -90.0) = 0.0, "invalid LHA");
      Assert (LHA (GHA => 90.0, Longitude => -180.0) = -90.0, "invalid LHA");

      Assert (LHA (GHA => 180.0, Longitude => 0.0) = 180.0, "invalid LHA");
      Assert (LHA (GHA => 180.0, Longitude => 90.0) = -90.0, "invalid LHA");
      Assert (LHA (GHA => 180.0, Longitude => 180.0) = 0.0, "invalid LHA");
      Assert (LHA (GHA => 180.0, Longitude => -90.0) = 90.0, "invalid LHA");
      Assert (LHA (GHA => 180.0, Longitude => -180.0) = 0.0, "invalid LHA");

      Assert (LHA (GHA => -90.0, Longitude => 0.0) = -90.0, "invalid LHA");
      Assert (LHA (GHA => -90.0, Longitude => 90.0) = 0.0, "invalid LHA");
      Assert (LHA (GHA => -90.0, Longitude => 180.0) = 90.0, "invalid LHA");
      Assert (LHA (GHA => -90.0, Longitude => -90.0) = -180.0, "invalid LHA");
      Assert (LHA (GHA => -90.0, Longitude => -180.0) = 90.0, "invalid LHA");

      Assert (LHA (GHA => -180.0, Longitude => 0.0) = -180.0, "invalid LHA");
      Assert (LHA (GHA => -180.0, Longitude => 90.0) = -90.0, "invalid LHA");
      Assert (LHA (GHA => -180.0, Longitude => 180.0) = 0.0, "invalid LHA");
      Assert (LHA (GHA => -180.0, Longitude => -90.0) = 90.0, "invalid LHA");
      Assert (LHA (GHA => -180.0, Longitude => -180.0) = 0.0, "invalid LHA");

      --  other values
      Assert (Equals (LHA (308.5867, 30.5833), -20.83), "invalid LHA ");

   end Test_LHA;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests
      (T : in out Equatorial_Coordinates_Test_Case)
   is
      use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_LHA'Access, "Local hour angle");
   end Register_Tests;

end Equatorial_Coordinates_Tests;
