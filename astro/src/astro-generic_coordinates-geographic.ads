-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Geographic coordinates.                                           --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, 3.244  (1992)                               --
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

   subtype Vector is Real_Arrays.Real_Vector (1 .. 3);

   -----------------
   --  Functions  --
   -----------------

   function Geocentric_Position (P  : Geographic_Coordinates;
                                 H : Real)
      return Vector;
   --  Geocentric position vector (in meters) for a point with given
   --  latitude, longitude, and height over the geoid.

end Astro.Generic_Coordinates.Geographic;