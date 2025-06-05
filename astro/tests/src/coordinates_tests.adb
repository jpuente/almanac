-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit.Assertions; use AUnit.Assertions;

with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

with Astro.Generic_Frame_Transformations;
with Astro.Generic_Julian_Time;
with Astro.Generic_Sidereal_Time;
with Astro.Generic_Coordinates;

package body Coordinates_Tests is

   -----------------
   --  Framework  --
   -----------------

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
         (Real, Real_Functions, Real_Arrays,
            Julian_Time, Frame_Transformations);

   package Coordinates is
     new Astro.Generic_Coordinates
      (Real, Real_Functions, Real_Arrays,
         Julian_Time, Frame_Transformations, Sidereal_Time);

   use Coordinates;

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Coordinates_Test_Case) return Message_String is
   begin
      return Format ("Coordinates tests");
   end Name;

   -----------
   -- Setup --
   -----------

   overriding procedure Set_Up
      (T : in out Coordinates_Test_Case) is
   begin
      null;
   end Set_Up;

   -------------------
   -- Test routines --
   -------------------

   --  Compare real values  --

   function Equals (X, Y : Real; Error : Real := 1.0E-6) return Boolean is
   begin
      return abs (X - Y) <= Error;
   end Equals;

   procedure Test_GHA (T : in out Test_Case'Class) is
      use Julian_Time;

      Error : constant Real := 1.0E-4;

      RA1   : constant Hours   := 0.0;
      JD1   : constant Date    := 2_460_587.0;    --  2024.10.03 12:00:00
      HA1   : constant Degrees := 192.684125;     --  12h 50m 44.19s

      RA2   : constant Hours   := 8.0;
      JD2   : constant Date    := 2_458_849.5;    -- 2020.01.01 00:00:00
      HA2   : constant Degrees :=  340.121833;    -- 22h 40m 29.24s

      RA3   : constant Hours := 16.0;
      JD3   : constant Date  := 2_462_683.25;     -- 2030.06.30 18:00:00
      HA3   : constant Degrees :=  308.847417;    -- 20h 35m 23.38s

      HA   : Degrees;

   begin

      HA := GHA (RA1, JD1);
      Assert (Equals (HA, HA1, Error), "Invalid GHA" & HA'Image);

      HA := GHA (RA2, JD2);
      Assert (Equals (HA, HA2, Error), "Invalid GHA" & HA'Image);

      HA := GHA (RA3, JD3);
      Assert (Equals (HA, HA3, Error), "Invalid GHA" & HA'Image);

   end Test_GHA;

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

   procedure Test_Spherical (T : in out Test_Case'Class) is
   begin
      null;
   end Test_Spherical;

   procedure Test_Horizontal (T : in out Test_Case'Class) is
      P : Geographic_Coordinates;
      E : Equatorial_Coordinates;
      H : Horizontal_Coordinates;

   begin
      --  Mederos, seminar notes (2024), example 2
      E := Equatorial_Coordinates'(Declination => 25.0,
                                   Hour_Angle => 30.0);
      P := Geographic_Coordinates'(Latitude => -30.0,
                                   Longitude => 0.0);
      H := Horizontal (E, P);

      Assert (Equals (H.Altitude, 27.931895, 0.01),
            "bad altitude: " & H.Altitude'Image);
      Assert (Equals (H.Azimuth, 329.1425, 1.0),
            "bad azimuth: " & H.Azimuth'Image);

      --  Mederos, seminar notes (2024), example 3
      E := Equatorial_Coordinates'(Declination => -1.4867,
                                   Hour_Angle => -20.83);
      P := Geographic_Coordinates'(Latitude => 33.6733,
                                   Longitude => 30.5833);
      H := Horizontal (E, P);

      Assert (Equals (H.Altitude, 49.74461322, 0.01),
            "bad altitude: " & H.Altitude'Image);
      Assert (Equals (H.Azimuth, 146.6256574, 1.0),
            "bad azimuth: " & H.Azimuth'Image);

      --  Mederos, seminar notes (2024), intercept example
      E := Equatorial_Coordinates'(Declination => -1.211667,
                                   Hour_Angle => 40.543333);
      P := Geographic_Coordinates'(Latitude => 34.336667,
                                   Longitude => -12.240000);
      H := Horizontal (E, P);

      Assert (Equals (H.Altitude, 37.982590, 0.01),
            "bad altitude: " & H.Altitude'Image);
      Assert (Equals (H.Azimuth, 236.0, 1.0),
            "bad azimuth: " & H.Azimuth'Image);
   end Test_Horizontal;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests (T : in out Coordinates_Test_Case) is
      use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_GHA'Access, "GHA");
      Register_Routine
        (T, Test_LHA'Access, "LHA");
      Register_Routine
        (T, Test_Spherical'Access, "Spherical coordinates");
      Register_Routine
        (T, Test_Horizontal'Access, "Horizontal coordinates");
   end Register_Tests;

end Coordinates_Tests;
