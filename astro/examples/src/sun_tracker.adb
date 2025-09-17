-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Sun tracker example.                                              --
--                                                                   --
-- This example was proposed by Maxim Reznik as a means to show      --
-- how the astro library can be used to get obeservational           --
-- coordinates of the Sun at a given location and time.              --
--                                                                   --
-- Further edited by Juan A. de la Puente to simplify the code and   --
-- fix a minor error.                                                -- 
--                                                                   --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Copyright (C) 2025 Maxim Reznik                                  --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Ada.Calendar;
with Ada.Calendar.Time_Zones;
with Ada.Calendar.Formatting;

with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Long_Long_Float_Text_IO; use Ada.Long_Long_Float_Text_IO;

with Astro.Generic_Solar_System;
with Astro.Generic_Dynamical_Time;
with Astro.Generic_Coordinates.Horizontal;

with Ephemeris;

procedure Sun_Tracker is

   package Solar_System is
      new Astro.Generic_Solar_System (Long_Long_Float);
   package Dynamical_Time is
      new Astro.Generic_Dynamical_Time (Long_Long_Float);

   package Horizontal is
      new Solar_system.Coordinates.Horizontal;
   package Equatorial renames Horizontal.Equatorial; --  REVIEW

   --  Compute apparent place of Sun at a given time. The apparent place
   --  is given in spherical coordinates (declination, right ascension or
   --  Greenwich Hour Angle, and distance from Earth barycentre).
   --  The apparent place is independent of the location of the observer.

   --  Time of the observation (UTC)
   --  Edit for other time values

   UTC : constant Ada.Calendar.Time_Zones.Time_Offset
      := Ada.Calendar.Time_Zones.UTC_Time_Offset;

   Time : constant Ada.Calendar.Time :=
   Ada.Calendar.Formatting.Time_Of
      (Year      => 2025,
       Month     => 07,
       Day       => 24,
       Hour      => 06,
       Minute    => 00,
       Second    => 00,
       Time_Zone => UTC);

   --  Time in Julian date format

   UT : constant Solar_System.Julian.Date :=
      Solar_System.Julian.Date_Of (Time);

   --  Terrestrial time equivalent (required for apparent place)

   TT : constant Solar_System.Julian.Date := Dynamical_Time.TT (UT);

   --  Place of Sun

   P    :  Solar_System.Spheric.Spherical_Coordinates;

   GHA  :  Solar_System.Coordinates.Degrees;
   LHA  :  Solar_System.Coordinates.Degrees;

   --  Observer's location
   --  Edit for other locations

   Location : constant Solar_System.Geographic.Geographic_Coordinates :=
     (Latitude  => 47.0,
      Longitude => 35.0);
   Height   : constant := 20.0; -- meters over geoid

   --  Equatorial and horizontal coordinates of observation
   E : Equatorial.Equatorial_Coordinates;
   H : Horizontal.Horizontal_Coordinates;

begin

   --  Apparent place (geocentric coordinates of Sun)

   New_Line;
   Put_Line ("Apparent place of Sun");
   New_Line;

   Put ("Observation time (UT) : ");
   Put (Ada.Calendar.Formatting.Image (Time, Time_Zone => UTC));
   New_Line;
   Put ("Julian date (UT)      : ");
   Put (UT, Exp => 0, Aft => 6);
   New_Line;
   Put ("Terrestrial time (TT) : ");
   Put (TT, Exp => 0, Aft => 6);
   New_Line (2);

   P   := Solar_System.Apparent_Place (Ephemeris.Sun, TT);
   GHA := Solar_System.Spheric.GHA (P.Right_Ascension, UT);

   Put ("Geocentric coordinates of Sun at given time");
   New_Line (2);
   Put ("Declination          : ");
   Put (P.Declination, Exp => 0, Fore => 3, Aft => 2);
   Put ("°");
   New_Line;
   Put ("Right ascension      : ");
   Put (P.Right_Ascension, Exp => 0, Fore => 3, Aft => 6);
   Put (" h");
   New_Line;
   Put ("Greenwich hour angle : ");
   Put (GHA, Exp => 0, Fore => 3, Aft => 4);
   Put ("°");
   New_Line;
   Put ("Distance             : ");
   Put (P.Distance, Exp => 0, Fore => 3, Aft => 9);
   Put (" AU");
   New_Line (2);
   Put_Line ("You can check these values on the USNO calculator");
   Put_Line ("(https://aa.usno.navy.mil/data/geocentric)");
   New_Line (2);

   --  Topocentric place (topocentric coordinates)

   P := Solar_System.Topocentric_Place
      (Ephemeris.Sun, TT, Location, Height);

   Put ("Topocentric coordinates of Sun at given time");
   New_Line (2);
   Put ("Declination          : ");
   Put (P.Declination, Exp => 0, Fore => 3, Aft => 2);
   Put ("°");
   New_Line;
   Put ("Right ascension      : ");
   Put (P.Right_Ascension, Exp => 0, Fore => 3, Aft => 6);
   Put (" h");
   New_Line;
   Put ("Greenwich hour angle : ");
   Put (GHA, Exp => 0, Fore => 3, Aft => 4);
   Put ("°");
   New_Line;
   Put ("Distance             : ");
   Put (P.Distance, Exp => 0, Fore => 3, Aft => 9);
   Put (" AU");
   New_Line (2);
   Put_Line ("You can check these values on the USNO calculator");
   Put_Line ("(https://aa.usno.navy.mil/data/topocentric)");
   New_Line;

   --  Horizontal coordinates for observation

   LHA := Equatorial.LHA (GHA, Location.Longitude);
   Put ("Local hour angle     : ");
   Put (LHA, Exp => 0, Fore => 3, Aft => 4);
   Put ("°");
   New_Line (2);

   E := (Declination => P.Declination, Hour_Angle => LHA);

   H := Horizontal.Horizontal (E, (Location.Latitude, Location.Longitude));  -- REVIEW

   Put ("Horizontal coordinates of Sun at given time and location");
   New_Line (2);
   Put ("Altitude             : ");
   Put (H.Altitude, Exp => 0, Fore => 3, Aft => 1);
   Put ("°");
   New_Line;
   Put ("Azimuth              : ");
   Put (H.Azimuth, Exp => 0, Fore => 3, Aft => 1);
   Put ("°");
   New_Line (2);
   Put_Line ("You can check these values on the USNO calculator");
   Put_Line ("(https://aa.usno.navy.mil/data/AltAz)");
   New_Line;

end Sun_Tracker;