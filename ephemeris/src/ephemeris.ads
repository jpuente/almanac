-----------------------------------------------------------------------
-- Ephemeris - Ada library for the JPL ephemerides.                  --
--                                                                   --
-- This package is the root of the hierarchy for the ephemeris       --
-- library. It provides basic definitions used in other packages.    --
--                                                                   --
-- WARNING:                                                          --
--     This version has only been tested with the DE200 ephemeris    --
-----------------------------------------------------------------------
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

package Ephemeris is

   pragma Pure (Ephemeris);

   --  List of available ephemeris files. 
   --  See https://ssd.jpl.nasa.gov/planets/eph_export.html for more
   --  information on JPL ephemeris files.

   type JPL_Ephemeris is (DE102,
                          DE200, -- only this ephemris is supported
                          DE202,
                          DE403,
                          DE405,
                          DE406,
                          DE410,
                          DE413,
                          DE414,
                          DE418,
                          DE421,
                          DE422,
                          DE423,
                          DE430,
                          DE431,
                          DE432,
                          DE440,
                          DE441);

   type Celestial_Body is
     (Mercury, Venus,  Earth,   Mars,  Jupiter,
      Saturn,  Uranus, Neptune, Pluto, Moon, Sun);

   Ephemeris_Error : exception;
   Date_Error      : exception;

end Ephemeris;
