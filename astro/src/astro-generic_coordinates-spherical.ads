-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Spherical coordinates.                                            --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, ch. 1 and 4 (1992)                          --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Astro.Generic_Julian_Time;

generic
package Astro.Generic_Coordinates.Spherical is

   package Julian is new Astro.Generic_Julian_Time (Real);

   ------------------
   --  Data types  --
   ------------------

   type Spherical_Coordinates is
      record
         Right_Ascension : Hours;
         --  0.0..24.0, East positive from vernal equinox (Aries)
         Declination     : Degrees;
         --  -90.0..+90.0, North positive from celestial equator
         Distance        : Real;
         --  AUs from geocentric coordinates origin
      end record;
   --  geocentric spherical coordinates of a celestial body

   --------------------------
   -- Conversion functions --
   --------------------------

   function GHA (RA : Hours; TU : Julian.Date)
      return Degrees;
   --  Greenwich hour angle from right ascension and Julian time

   function Spherical (U : Vector) return Spherical_Coordinates;
   --  Equatorial speherical coordinates for a geocentric vector
   --  representing equatorial rectangular coordinates

end Astro.Generic_Coordinates.Spherical;
