-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Apparent and topocentric places of Solar system bodies.           --
--                                                                   --
-----------------------------------------------------------------------
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, 3.3 (1992)                                  --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Astro.Generic_Julian_Time;
with Astro.Generic_Coordinates;
with Astro.Generic_Coordinates.Spherical;
with Astro.Generic_Coordinates.Geographic;

generic
   type Real is digits <>;
package Astro.Generic_Solar_System is

   package Julian is new Astro.Generic_Julian_Time (Real);
   package Coordinates is new Astro.Generic_Coordinates (Real);
   package Spheric is new  Coordinates.Spherical;
   package Geographic is new Coordinates.Geographic;
   use Spheric, Geographic;

   ------------------
   --  Data types  --
   ------------------

   subtype Solar_System_Body is Celestial_Body;
   --     (Mercury, Venus,  Earth,   Mars,  Jupiter,
   --      Saturn,  Uranus, Neptune, Pluto, Moon, Sun);

   ---------------
   -- Functions --
   ---------------

   function Apparent_Place
     (Target : Solar_System_Body;
      TT     : Julian.Date)
   return Spherical_Coordinates;

   --  Geocentric position of target at terrestrial time TT.
   --  The position is given in spherical coordinates referred
   --  to the true equator and equinox of date.

   function Topocentric_Place
     (Target    : Solar_System_Body;
      JTD       : Julian.Date;                --  TDT
      Position  : Geographic_Coordinates;
      Height    : Real)
   return Spherical_Coordinates;

   --  Topocentric position of object at Julian terrestrial date JTD.
   --  The result is given in spherical coordinates referred
   --  to the true equator and equinox of date.
   --  The observer's position is given by geocentric latitude and longitude
   --  in degrees and height in meters.

end Astro.Generic_Solar_System;