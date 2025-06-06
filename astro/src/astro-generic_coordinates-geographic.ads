-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Geographic coordinates.                                           --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, ch. 1 and 4 (1992)                          --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
generic
package Astro.Generic_Coordinates.Geographic is

   ------------------
   --  Data types  --
   ------------------

   type Geographic_Coordinates is
   record
      Latitude        : Degrees;
      --  -90..+90, North positive from Equator
      Longitude       : Degrees;
      --  -180..+180, East positive from prime meridian
   end record;
   --  position of a point on Earth surface

end Astro.Generic_Coordinates.Geographic;