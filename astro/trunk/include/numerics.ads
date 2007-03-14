-----------------------------------------------------------------------
-- Astro - Ada 2005 library for astrometric calculations             --
--                                                                   --
-- This package provides numerics data types and functions used      --
-- in other packages.    --
--                                                                   --
-- WARNING: The astro library relies on the ephemeris library.       --
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
with Ada.Numerics.Generic_Elementary_Functions;
--with Ada.Numerics.Generic_Real_Arrays;
with Generic_Real_Arrays;
package Numerics is

   -- Numeric data types
   subtype Real   is Long_long_Float;

   package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);
   package Real_Arrays is
     --new Ada.Generic_Real_Arrays (Real);
     new Generic_Real_Arrays (Real);

   subtype Vector is Real_Arrays.Real_Vector(1..3);
   subtype Matrix is Real_Arrays.Real_Matrix(1..3,1..3);

   -- Constants
   Pi : constant := Ada.Numerics.Pi;
   AU : constant := 0.149597870659999996E+09;  -- Astronomical unit in km
   C  : constant := 299792.458;                -- Light speed in km/s
   Mu : constant := 1.32712438E+20;            -- Heliocentric gravitational
                                               -- constant, m**3/s**2
   EM : constant := 0.813005869999999931E+02;  -- Earth-Moon mass ratio
   R  : constant := 6378.140;                  -- Earth radius in km
   F  : constant := 0.00335281;                -- Earth flattening factor

end Numerics;
