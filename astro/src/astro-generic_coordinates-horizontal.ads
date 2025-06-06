-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Horizontal coordinates.                                           --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, ch. 1 and 4 (1992)                          --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Astro.Generic_Coordinates.Equatorial;
with Astro.Generic_Coordinates.Geographic;
generic
package Astro.Generic_Coordinates.Horizontal is

   package Equatorial is new Astro.Generic_Coordinates.Equatorial;
   use Equatorial;

   package Geographic is new Astro.Generic_Coordinates.Geographic;
   use Geographic;

   ------------------
   --  Data types  --
   ------------------

   type Horizontal_Coordinates is
      record
         Altitude        : Degrees;
         --  -90..+90 from horizon
         Azimuth         : Degrees;
         --  0..360 Eastwards from North
   end record;
   --  topocentric apparent position of a celestial body

   --------------------------
   -- Conversion functions --
   --------------------------

   function Horizontal (E : Equatorial_Coordinates; P : Geographic_Coordinates)
      return Horizontal_Coordinates;
   --  altitude and azimut at position P from declination and GHA

end Astro.Generic_Coordinates.Horizontal;
