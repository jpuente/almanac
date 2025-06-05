-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- This package provides definitions for various types of            --
-- coordinates.                                                      --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, ch. 1 and 4 (1992)                          --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

with Astro.Generic_Frame_Transformations;
with Astro.Generic_Julian_Time;
with Astro.Generic_Sidereal_Time;

generic
   type Real is digits <>;
   with package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);
  with package Real_Arrays is
     new Ada.Numerics.Generic_Real_Arrays (Real);

   with package Julian_Time is
     new Astro.Generic_Julian_Time (Real);
   with package Frame_Transformations is
         new Astro.Generic_Frame_Transformations
      (Real, Real_Functions, Real_Arrays, Julian_Time);
   with package Sidereal_Time is
      new Astro.Generic_Sidereal_Time
         (Real, Real_Functions, Real_Arrays,
            Julian_Time, Frame_Transformations);

package Astro.Generic_Coordinates is

   subtype Degrees is Real;
   subtype Hours   is Real;

   subtype Vector is Real_Arrays.Real_Vector (1 .. 3);

   package Julian renames Julian_Time;

   ------------------
   --  Data types  --
   ------------------

   type Spherical_Coordinates is
      record
         Declination : Degrees;
         --  -90.0..+90.0, North positive from celestial equator
         RA          : Hours;
         --  0.0..24.0, East positive from vernal equinox (Aries)
         Distance    : Real;
         --  AUs from geocentric coordinates origin
      end record;
   --  geocentric equatorial coordinates of a celestial body

   type Equatorial_Coordinates is
      record
         Declination     : Degrees;
         --  -90..+90, North positive from celestial equator
         Hour_Angle      : Degrees;
         --  -180..+180, West positive from  Greenwich hour circle (GHA)
         --  or from  observer's hour circle (LHA)
      end record;
   --  geocentric apparent position of a celestial body

   type Horizontal_Coordinates is
      record
         Altitude        : Degrees;
         --  -90..+90 from horizon
         Azimuth         : Degrees;
         --  0..360 Eastwards from North
   end record;
   --  topocentric apparent position of a celestial body

   type Geographic_Coordinates is
      record
         Latitude        : Degrees;
         --  -90..+90, North positive from Equator
         Longitude       : Degrees;
         --  -180..+180, East positive from prime meridian
      end record;
   --  position of a point on Earth surface

   --------------------------
   -- Conversion functions --
   --------------------------

   function GHA (RA : Hours; TU : Julian.Date)
      return Degrees;
   --  Greenwich hour angle from right ascension and Julian time

   function LHA (GHA : Degrees; Longitude : Degrees)
      return Degrees;
   --  local hour angle from Greenwich hour angle

   function Spherical (U : Vector) return Spherical_Coordinates;
   --  Equatorial speherical coordinates for a geocentric vector
   --  representing equatorial rectangular coordinates

   function Horizontal (E : Equatorial_Coordinates; P : Geographic_Coordinates)
      return Horizontal_Coordinates;
   --  altitude and azimut at position P from declination and GHA

end Astro.Generic_Coordinates;
