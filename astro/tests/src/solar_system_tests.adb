----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit.Assertions; use AUnit.Assertions;

with Astro.Generic_Solar_System;
with Astro.Generic_Dynamical_Time;

with Ephemeris; use Ephemeris;

package body Solar_System_Tests is

   ---------------
   -- Framework --
   ---------------

   type Real is new Long_Long_Float;

   package Solar_System is
      new Astro.Generic_Solar_System (Real);

   package Julian renames Solar_System.Julian;
   package Dynamical_Time is
      new Astro.Generic_Dynamical_Time (Real);

   use Solar_System;
   use Coordinates, Spheric, Geographic;

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Solar_System_Test_Case) return Message_String is
   begin
      return Format ("Solar system time tests");
   end Name;

   ------------
   -- Set_Up --
   ------------

   --  Time values
   TU1 : Julian.Date; -- UT
   TT1 : Julian.Date; -- TT

   --  Position of Sun at TT1
   RA1         : Hours;   --  right ascension
   DEC1        : Degrees; --  declination
--   Distance    : Real;    --  AU; not tested

   --  Observer position on Earth
   Observer    : Geographic_Coordinates;
   Height      : Real;  -- meters

   RA2         : Hours;
   DEC2        : Degrees;

   overriding procedure Set_Up
      (T : in out Solar_System_Test_Case)
   is
   begin
      TU1  := 2460833.125000;   --  2025.06.06 15:00:00 UTC
      TT1  := 2460833.125799;   --  2025.06.06 15:01:09
      RA1  := 4.997889;         --  hours, see below
      DEC1 := 22.718333;        --  from nautical almanac
      --  GHA Sun   =  45.30833º (from nautical almanac)
      --  GHA Aries = 120.27667º (from nautical almanac)
      --  RA Sun = GHA Aries - GHA Sun = 74.9968337º

      Observer := (Latitude => 36.4617, Longitude => -6.2056);
      Height   := 30.0;

      --  Real Observatorio de la Armada, San Fernando
      RA2  :=  4.997795;       --  from USNO online calculator
      DEC2 := 22.718131;       --  from USNO online calculator

   end Set_Up;

   --------------------
   --  Test routines --
   --------------------

   --  Compare real values
   function Equals (X, Y : Real; Error : Real := 1.0E-6) return Boolean is
   begin
      return abs (X - Y) <= Error;
   end Equals;

   procedure Test_Apparent_Place (T : in out Test_Case'Class)
   is
      use Dynamical_Time;
      TT0 : constant Julian.Date := TT (TU1);  -- terrestrial time
      P   : Spherical_Coordinates;
   begin
      --  Assert (Equals (TT0, TT1, 1.0E-4), "Bad TT1" & TT0'Image);

      P := Apparent_Place (Sun, TT1);

      Assert (Equals (P.Right_Ascension, RA1, 1.0E-4),
         "Bad RA " & P.Right_Ascension'Image);
      Assert (Equals (P.Declination, DEC1, 1.0E-3),
         "Bad declination" & P.Declination'Image);
   end Test_Apparent_Place;

   procedure Test_Topocentric_Place (T : in out Test_Case'Class) is
      P : Spherical_Coordinates;
   begin
   --   P := Topocentric_Place (Sun, TT1, Observer, Height);
      --  Assert (Equals (P.Right_Ascension, RA2, 1.0E-4),
      --   "Bad RA " & P.Right_Ascension'Image);
      --  Assert (Equals (P.Declination, DEC2, 1.0E-3),
      --   "Bad declination" & P.Declination'Image);
      null;
   end Test_Topocentric_Place;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests (T : in out Solar_System_Test_Case) is
      use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_Apparent_Place'Access, "Apparent place");
      Register_Routine
        (T, Test_Topocentric_Place'Access,
            "Topocentric place");
   end Register_Tests;

end Solar_System_Tests;