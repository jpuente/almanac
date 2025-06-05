-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- This package provides frame transformations for position          --
-- and velocity vectors.                                             --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, ch. 3 (1992)                                --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

with Astro.Generic_Julian_Time;

generic
   type Real is digits <>;
   with package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);
   with package Real_Arrays is
     new Ada.Numerics.Generic_Real_Arrays (Real);
   with package Julian_Time is
     new Astro.Generic_Julian_Time (Real);

package Astro.Generic_Frame_Transformations is

   subtype Vector is Real_Arrays.Real_Vector (1 .. 3);

   package Julian renames Julian_Time;

   procedure Correct_Light_Deflection
     (U  : in out Vector;               -- geocentric position of the body
      Q  :        Vector;               -- heliocentric position of the body
      EH :        Vector);              -- heliocentric position of the Earth

   procedure Correct_Aberration
     (U       : in out Vector;          -- geocentric position vector
      VEB     :        Vector);         -- barycentric Earth velocity vector

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

end Astro.Generic_Frame_Transformations;
