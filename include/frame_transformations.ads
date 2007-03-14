-----------------------------------------------------------------------
-- Astro - Ada 2005 library for astrometry.                          --
--                                                                   --
-- This package provides frame transformation procedures.            --
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
with Numerics;
with Julian_Time;
package Frame_Transformations is

   subtype Real   is Numerics.Real;
   subtype Vector is Numerics.Vector;

   package Julian renames Julian_Time;

   procedure Correct_Light_Deflection
     (U  : in out Vector;  -- geocentric position of the body
      Q  :        Vector;  -- heliocentric position of the body
      EH :        Vector);  -- heliocentric position of the Earth

   procedure Correct_Aberration
     (U       : in out Vector;  -- geocentric position vector
      VEB     :        Vector); -- barycentric Earth velocity vector

   procedure Precess
     (U    : in out Vector;             -- geocentric position vector
      TDB0 :        Julian.Date;        -- initial date
      TDB1 :        Julian.Date);       -- final date

   procedure Nutate
     (U   : in out Vector;              -- geocentric position vector
      JD  :        Julian.Date);        -- usually terrestrial time

   procedure Get_Nutation_Angles
     (JD        :     Julian.Date;
      Delta_Psi : out Real;             -- nutation in longitude
      Delta_Eps : out Real);            -- nutation in obliquity

end Frame_Transformations;
