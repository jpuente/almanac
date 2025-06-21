-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Equatorial coordinates.                                           --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, ch. 1 and 4 (1992)                          --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
generic
package Astro.Generic_Coordinates.Equatorial is

   ------------------
   --  Data types  --
   ------------------

   type Equatorial_Coordinates is
      record
         Declination     : Degrees;
         --  -90..+90, North positive from celestial equator
         Hour_Angle      : Degrees;
         --  -180..+180, West positive from  Greenwich hour circle (GHA)
         --  or from  observer's hour circle (LHA)
      end record;
      --  geocentric apparent position of a celestial body

   --------------------------
   -- Conversion functions --
   --------------------------

   function LHA (GHA : Degrees; Longitude : Degrees)
      return Degrees;
   --  local hour angle from Greenwich hour angle

end Astro.Generic_Coordinates.Equatorial;
