----------------------------------------------------------------------
-- Astro - Ada 2005 library for astrometry.                          --
--                                                                   --
-- This package provides abstractions for Julian time.               --
--                                                                   --
-----------------------------------------------------------------------
--  Copyright (C) 2007 Juan A. de la Puente  <jpuente@dit.upm.es>    --
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
with Ada.Numerics.Generic_Real_Arrays;

-- This unit provides a framework for the instantiation of the Astro
-- library components for a particular floating point type and
-- ephemeris source.

generic
   type Real is digits <>;
   with package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);
   with package Real_Arrays is
     new Ada.Numerics.Generic_Real_Arrays (Real);
package Astro.Framework is

   package Julian_Time is
     new Astro.Generic_Julian_Time(Real);

   package Frame_Transformations is
     new Astro.Generic_Frame_Transformations
       (Real,
        Real_Functins,
        Real_Arrays,
        Julian_Time);

end Astro.Framework;
