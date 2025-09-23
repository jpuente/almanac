-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Sun tracker example.                                             --
--                                                                   --
--   Compute apparent place and horizontal coordinates of Sun        --
--   at a given time and location.                                   --
--                                                                   --
--  The apparent place is given in spherical coordinates             --
--  (declination and right ascension or Greenwich Hour Angle).       --
--  It is independent of the location of the observer.               --
--                                                                   --
--  The horizontal coordinates (altitude and azimuth)                --
--  depend on the observer's location.                               --
--                                                                   --
--  This example was proposed by Maxim Reznik as a means to show     --
--  how the astro library can be used to get observational           --
--  coordinates of the Sun at a given location and time.             --
--                                                                   --
--  Further edited by Juan A. de la Puente to simplify the code and  --
--  fix a minor error.                                               --
--                                                                   --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Copyright (C) 2025 Maxim Reznik                                  --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Ada.Calendar.Time_Zones;
with Ada.Calendar.Formatting;     use Ada.Calendar.Formatting;

with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Long_Long_Float_Text_IO; use Ada.Long_Long_Float_Text_IO;

with Astro.Generic_Solar_System;
with Astro.Generic_Terrestrial_Time;
with Astro.Generic_Coordinates.Horizontal;

with Ephemeris;
procedure Sun_Tracker is

   package Solar_System is
      new Astro.Generic_Solar_System (Long_Long_Float);
   package Terrestrial_Time is
      new Astro.Generic_Terrestrial_Time (Long_Long_Float);
   package Horizontal is
      new Solar_system.Coordinates.Horizontal;
   package Equatorial renames Horizontal.Equatorial;

   --  Time values

   UTC_Offset : constant Ada.Calendar.Time_Zones.Time_Offset
      := Ada.Calendar.Time_Zones.UTC_Time_Offset;

   UT0 : Ada.Calendar.Time := Ada.Calendar.Clock;
   UT  : Solar_System.Julian.Date; --  UT in Julian date format
   TT  : Solar_System.Julian.Date; --  Terrestrial time

   --  Spherical coordinates of Sun

   P    :  Solar_System.Spheric.Spherical_Coordinates;
   GHA  :  Solar_System.Coordinates.Degrees;
   LHA  :  Solar_System.Coordinates.Degrees;

   --  Observer's location

   Location : Solar_System.Geographic.Geographic_Coordinates;

   --  Equatorial and horizontal coordinates of observation
   E : Equatorial.Equatorial_Coordinates;
   H : Horizontal.Horizontal_Coordinates;

begin

   ---------------------------
   --  Time of observation  --
   ---------------------------

   Put ("Observation time (UT) (YYYY-MM-DD HH:MM:SS) ");
   declare
      S : String (1 .. 80);
      N : Natural;
   begin
      Get_Line (S, N);
      UT0 := Value (S (1 .. N), Time_Zone => UTC_Offset);
   exception
      when Constraint_Error =>
         Put_Line ("Bad format, using computer clock");
         UT0 := Ada.Calendar.Clock;
   end;

   --  Terrestrial time in Julian notation
   UT := Solar_System.Julian.Date_Of (UT0);
   TT := Terrestrial_Time.TT (UT);

   --  Put time values
   New_Line;
   Put ("UT                    : ");
      Put_Line (Image (UT0, Time_Zone =>  UTC_Offset));
   Put ("Julian date (UT)      : ");
      Put (UT, Exp => 0, Aft => 6); New_Line;
   Put ("Terrestrial time (TT) : ");
      Put (TT, Exp => 0, Aft => 6); New_Line (2);

   -----------------------------
   --  Apparent place of Sun  --
   -----------------------------

   P   := Solar_System.Apparent_Place (Ephemeris.Sun, TT);
   GHA := Solar_System.Spheric.GHA (P.Right_Ascension, UT);

   Put ("Apparent (geocentric) place of Sun"); New_Line (2);
   Put ("Declination          : ");
   Put (P.Declination, Exp => 0, Fore => 3, Aft => 2);
      Put ("°"); New_Line;
   Put ("Right ascension      : ");
   Put (P.Right_Ascension, Exp => 0, Fore => 3, Aft => 6);
      Put (" h"); New_Line;
   Put ("Greenwich hour angle : ");
   Put (GHA, Exp => 0, Fore => 3, Aft => 3);
      Put ("°"); New_Line (2);
   Put ("You can check these values on the USNO calculator");
   Put ("(https://aa.usno.navy.mil/data/geocentric)");
   New_Line;

   ---------------------------
   --  Observer's location  --
   ---------------------------

   --  Get location
   New_Line;
   Put ("Observer's location (latitude, longitude, decimal degrees): ");
   declare
      Lt, Lg : Solar_System.Coordinates.Degrees;
   begin
      Get (Lt); Get (Lg);
      Location := (Latitude  => Lt,
                   Longitude => Lg);
   exception
      when others =>
         Put_Line ("Bad format, using default location");
         Location := (Latitude  => 36.4617,
                      Longitude => -6.2056);
   end;

   -----------------------------
   --  Horizontal coordinates --
   -----------------------------

   LHA := Equatorial.LHA (GHA, Location.Longitude);
   E := (Declination => P.Declination, Hour_Angle => LHA);
   H := Horizontal.Horizontal (E, (Location.Latitude, Location.Longitude));

   Put ("Horizontal coordinates of Sun"); New_Line (2);
   Put ("Location             : ");
   Put (Location.Latitude, Fore => 3, Aft => 4, Exp => 0);
   Put (Location.Longitude, Fore => 3, Aft => 4, Exp => 0); New_Line;

   Put ("Local hour angle     : ");
   Put (LHA, Exp => 0, Fore => 3, Aft => 4); Put ("°"); New_Line (2);
   Put ("Altitude             : ");
   Put (H.Altitude, Exp => 0, Fore => 3, Aft => 1); Put ("°"); New_Line;
   Put ("Azimuth              : ");
   Put (H.Azimuth, Exp => 0, Fore => 3, Aft => 1); Put ("°"); New_Line;
   New_Line;
   Put_Line ("You can check these values on the USNO calculator");
   Put_Line ("(https://aa.usno.navy.mil/data/AltAz)");
   New_Line;

end Sun_Tracker;