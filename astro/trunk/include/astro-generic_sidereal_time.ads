-----------------------------------------------------------------------
--  Astro - Ada 2005 library for astrometry.                          --
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
with Astro.Generic_Julian_Time;
with Astro.Generic_Frame_Transformations;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

-- This package provides abstractions for sidereal time.

generic
   type Real is digits <>;
   with package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);
   with package Real_Arrays is
     new Ada.Numerics.Generic_Real_Arrays (Real);
   with package Julian_Time is
     new Astro.Generic_Julian_Time(Real);
   with package Frame_transformations is
     new Astro.Generic_Frame_Transformations
       (Real, Real_Functions, Real_Arrays, Julian_Time);
package Astro.Generic_Sidereal_Time is
   -- For maximum precision Julian dates should based on UT1 or TDT.
   -- UTC-based Julian dates are acceptable for precision <= 1s.

   subtype Time is Real range 0.0..86_400.0;
   -- Sidereal time in seconds. Equals the number of seconds elapsed since
   -- the transit of the vernal point (Aries).

   function GMST (D: Julian_Time.Date) return Time;
   -- Greenwich Mean Sidereal Time in seconds.

   function GST  (D: Julian_Time.Date) return Time;
   -- Greenwich Apparent Sidereal Time in seconds.

end Astro.Generic_Sidereal_Time;
