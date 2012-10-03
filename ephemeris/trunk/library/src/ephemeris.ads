--  $Id$:
-----------------------------------------------------------------------
-- Ephemeris - Ada library for the JPL ephemerides                   --
--                                                                   --
-- This package is the root of the hierarchy for the ephemeris       --
-- library. It provides basic definitions used in other packages.    --
--                                                                   --
-- WARNING:                                                          --
--     This version has only been tested with the DE200 ephemeris    --
-----------------------------------------------------------------------
--  Copyright (C) 2006 Juan A. de la Puente  <jpuente@dit.upm.es>    --
--  This unit was originally developed by Juan A. de la Puente.      --
-----------------------------------------------------------------------
-- This library is free software; you can redistribute it and/or     --
-- modify it under the terms of the GNU General Public               --
-- License as published by the Free Software Foundation; either      --
-- version 2 of the License, or (at your option) any later version.  --
--                                                                   --
-- This library is distributed in the hope that it will be useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of    --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
-- General Public License for more details.                          --
--                                                                   --
-- You should have received a copy of the GNU General Public         --
-- License along with this library; if not, write to the             --
-- Free Software Foundation, Inc., 59 Temple Place - Suite 330,      --
-- Boston, MA 02111-1307, USA.                                       --
-----------------------------------------------------------------------

package Ephemeris is

   pragma Pure (Ephemeris);

   --  List of available ephemeris files. See http://ssd.jpl.nasa.gov/
   --  for a description of the different sets of ephemerides.

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
                          DE423);

   type Celestial_Body is
     (Mercury, Venus,  Earth,   Mars,  Jupiter,
      Saturn,  Uranus, Neptune, Pluto, Moon, Sun);

   Ephemeris_Error : exception;
   Date_Error      : exception;

end Ephemeris;
