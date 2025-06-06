-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit.Assertions; use AUnit.Assertions;

with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;
with Astro.Generic_Coordinates.Spherical;

package body Spherical_Coordinates_Tests is

   -----------------
   --  Framework  --
   -----------------

   type Real is new Long_Long_Float;

   package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);

   package Real_Arrays is
      new Ada.Numerics.Generic_Real_Arrays (Real);

   package Coordinates is
     new Astro.Generic_Coordinates (Real, Real_Functions, Real_Arrays);

   package S_Coordinates is
      new Coordinates.Spherical;

   use S_Coordinates;

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Spherical_Coordinates_Test_Case) return Message_String is
   begin
      return Format ("Spherical Coordinates tests");
   end Name;

   -----------
   -- Setup --
   -----------

   overriding procedure Set_Up
      (T : in out Spherical_Coordinates_Test_Case) is
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

   procedure Test_GHA (T : in out Test_Case'Class) is
      use Coordinates;

      RA  : Hours;
      TU  : Julian.Date;
      HA1 : Degrees;
      HA  : Degrees;

   begin
      RA  := 12.0;
      TU  := 2_460_370.0; -- 2024-02-29, Noon
      HA1 := 158.798625;  --  10h 35m 11.67s
      HA := GHA (RA, TU);
      Assert (Equals (HA, HA1, 1.0E-5), "Bad GHA" & HA'Image);

      RA  := 0.0;
      TU  := 2_462_683.25;  -- 2030.06.30 18:00:00
      HA1 := 188.847417;    --  12h 35m 23.38s
      HA  := GHA (RA, TU);
      Assert (Equals (HA, HA1, 1.0E-5), "Bad GHA" & HA'Image);

      RA  := 4.975050;      --  Data for Sun
      TU  := 2460832.80;    --  2025.06.06 07:12
      HA1 := 288.330490;    --  19h 13m 19.32s
      HA  := GHA (RA, TU);
      Assert (Equals (HA, HA1, 1.0E-5), "Bad GHA" & HA'Image);

   end Test_GHA;

   procedure Test_Spherical (T : in out Test_Case'Class) is
      use Coordinates;

      U  : Vector;                 --  Cartesian coordinates
      P1 : Spherical_Coordinates;  --  expected
      P  : Spherical_Coordinates;  --  calculated

   begin
      U  := (1.0, 1.0, 1.0);             -- AU
      P1 := (3.0, 35.264390, 1.732051);  -- RA, dec, r
      P  := Spherical (U);
      Assert (Equals (P.Right_Ascension, P1.Right_Ascension, 1.0E-5),
         "Invalid right ascension" & P.Right_Ascension'Image);
      Assert (Equals (P.Declination, P1.Declination, 1.0E-5),
         "Invalid declination" & P.Declination'Image);
      Assert (Equals (P.Distance, P1.Distance, 1.0E-5),
         "Invalid distance" & P.Distance'Image);

      U  := (1.0, -1.0, 1.0);             -- AU
      P1 := (21.0, 35.264390, 1.732051);  -- RA, dec, r
      P  := Spherical (U);
      Assert (Equals (P.Right_Ascension, P1.Right_Ascension, 1.0E-5),
         "Invalid right ascension" & P.Right_Ascension'Image);
      Assert (Equals (P.Declination, P1.Declination, 1.0E-5),
         "Invalid declination" & P.Declination'Image);
      Assert (Equals (P.Distance, P1.Distance, 1.0E-5),
         "Invalid distance" & P.Distance'Image);

      U  := (1.0, -1.0, -1.0);             -- AU
      P1 := (21.0, -35.264390, 1.732051);  -- RA, dec, r
      P  := Spherical (U);
      Assert (Equals (P.Right_Ascension, P1.Right_Ascension, 1.0E-5),
         "Invalid right ascension" & P.Right_Ascension'Image);
      Assert (Equals (P.Declination, P1.Declination, 1.0E-5),
         "Invalid declination" & P.Declination'Image);
      Assert (Equals (P.Distance, P1.Distance, 1.0E-5),
         "Invalid distance" & P.Distance'Image);

      --  limit cases
      U  := (0.0, 0.0, 0.0);
      P1 := (0.0, 0.0, 0.0);
      P  := Spherical (U);
      Assert (Equals (P.Right_Ascension, P1.Right_Ascension, 1.0E-5),
         "Invalid right ascension" & P.Right_Ascension'Image);
      Assert (Equals (P.Declination, P1.Declination, 1.0E-5),
         "Invalid declination" & P.Declination'Image);
      Assert (Equals (P.Distance, P1.Distance, 1.0E-5),
         "Invalid distance" & P.Distance'Image);

      U  := (0.0, 0.0, 1.0);
      P1 := (0.0, 90.0, 1.0);
      P  := Spherical (U);
      Assert (Equals (P.Right_Ascension, P1.Right_Ascension, 1.0E-5),
         "Invalid right ascension" & P.Right_Ascension'Image);
      Assert (Equals (P.Declination, P1.Declination, 1.0E-5),
         "Invalid declination" & P.Declination'Image);
      Assert (Equals (P.Distance, P1.Distance, 1.0E-5),
         "Invalid distance" & P.Distance'Image);

      U  := (0.0, 0.0, -1.0);
      P1 := (0.0, -90.0, 1.0);
      P  := Spherical (U);
      Assert (Equals (P.Right_Ascension, P1.Right_Ascension, 1.0E-5),
         "Invalid right ascension" & P.Right_Ascension'Image);
      Assert (Equals (P.Declination, P1.Declination, 1.0E-5),
         "Invalid declination" & P.Declination'Image);
      Assert (Equals (P.Distance, P1.Distance, 1.0E-5),
         "Invalid distance" & P.Distance'Image);

   end Test_Spherical;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests
      (T : in out Spherical_Coordinates_Test_Case)
   is
      use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_GHA'Access, "Greenwich hour angle");
      Register_Routine
        (T, Test_Spherical'Access, "Spherical conversion");
   end Register_Tests;

end Spherical_Coordinates_Tests;
