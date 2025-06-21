-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit.Assertions; use AUnit.Assertions;

--  with Ada.Numerics.Generic_Elementary_Functions;
--  with Ada.Numerics.Generic_Real_Arrays;

with Astro.Generic_Coordinates.Horizontal;

package body Horizontal_Coordinates_Tests is

   -----------------
   --  Framework  --
   -----------------

   type Real is new Long_Long_Float;

   package Coordinates is
     new Astro.Generic_Coordinates (Real);

   package Horizontal is
      new Coordinates.Horizontal;
   use Horizontal;
   use Equatorial;  --  instantiated in Horizontal
   use Geographic;  --  instantiated in Horizontal

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Horizontal_Coordinates_Test_Case) return Message_String is
   begin
      return Format ("Horizontal Coordinates tests");
   end Name;

   -----------
   -- Setup --
   -----------

   overriding procedure Set_Up
      (T : in out Horizontal_Coordinates_Test_Case) is
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

   procedure Test_Horizontal (T : in out Test_Case'Class) is

      P : Geographic_Coordinates;
      E : Equatorial_Coordinates;
      H : Horizontal_Coordinates;

      function AZ (E : Equatorial_Coordinates; P : Geographic_Coordinates)
            return Horizontal_Coordinates
      renames Horizontal.Horizontal;

   begin
      --  Mederos, seminar notes (2024), example 2
      E := Equatorial_Coordinates'(Declination => 25.0,
                                   Hour_Angle => 30.0);
      P := Geographic_Coordinates'(Latitude => -30.0,
                                   Longitude => 0.0);
      H := AZ (E, P);

      Assert (Equals (H.Altitude, 27.931895, 0.01),
            "bad altitude: " & H.Altitude'Image);
      Assert (Equals (H.Azimuth, 329.1425, 1.0),
            "bad azimuth: " & H.Azimuth'Image);

      --  Mederos, seminar notes (2024), example 3
      E := Equatorial_Coordinates'(Declination => -1.4867,
                                   Hour_Angle => -20.83);
      P := Geographic_Coordinates'(Latitude => 33.6733,
                                   Longitude => 30.5833);
      H := AZ (E, P);

      Assert (Equals (H.Altitude, 49.74461322, 0.01),
            "bad altitude: " & H.Altitude'Image);
      Assert (Equals (H.Azimuth, 146.6256574, 1.0),
            "bad azimuth: " & H.Azimuth'Image);

      --  Mederos, seminar notes (2024), intercept example
      E := Equatorial_Coordinates'(Declination => -1.211667,
                                   Hour_Angle => 40.543333);
      P := Geographic_Coordinates'(Latitude => 34.336667,
                                   Longitude => -12.240000);
      H := AZ (E, P);

      Assert (Equals (H.Altitude, 37.982590, 0.01),
            "bad altitude: " & H.Altitude'Image);
      Assert (Equals (H.Azimuth, 236.0, 1.0),
            "bad azimuth: " & H.Azimuth'Image);
   end Test_Horizontal;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests
      (T : in out Horizontal_Coordinates_Test_Case)
   is
      use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_Horizontal'Access, "Horizontal conversion");
   end Register_Tests;

end Horizontal_Coordinates_Tests;
