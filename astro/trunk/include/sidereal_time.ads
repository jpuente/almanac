-----------------------------------------------------------------------
-- Astro - Ada 2005 library for astrometry.                          --
--                                                                   --
-- This package provides abstractions for sidereal time.             --
--                                                                   --
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
with Julian_Time;
with Numerics;
package Sidereal_Time is
   -- Functions for computing sidereal time.
   -- For maximum precision Julian dates should based on UT1 or TDT.
   -- UTC-based Julian dates are acceptable for precision <= 1s.

   subtype Time is Numerics.Real range 0.0..86_400.0;
   -- Sidereal time in seconds. Equals the number of seconds elapsed since
   -- the transit of the vernal point (Aries).

   function GMST (D: Julian_Time.Date) return Time;
   -- Greenwich Mean Sidereal Time in seconds.

   function GST  (D: Julian_Time.Date) return Time;
   -- Greenwich Apparent Sidereal Time in seconds.

end Sidereal_Time;
