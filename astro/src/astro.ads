-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- This package is the root of the hierarchy for the astro           --
-- library. It provides basic definitions used in other packages.    --
-----------------------------------------------------------------------
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Ephemeris;
package Astro is
   pragma Pure (Astro);

   subtype Celestial_Body is Ephemeris.Celestial_Body;
   --     (Mercury, Venus,  Earth,   Mars,  Jupiter,
   --      Saturn,  Uranus, Neptune, Pluto, Moon, Sun);

   Ephemeris_Error : exception renames Ephemeris.Ephemeris_Error;
   Date_Error      : exception renames Ephemeris.Date_Error;

end Astro;