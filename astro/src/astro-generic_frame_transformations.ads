-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- This package provides frame transformations for position          --
-- and velocity vectors.                                             --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac (1992) ch. 1 & 3 (1992)  - cited as ESAA     --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

with Astro.Generic_Julian_Time;

generic
   type Real is digits <>;
package Astro.Generic_Frame_Transformations is

   package Real_Functions is
      new Ada.Numerics.Generic_Elementary_Functions (Real);

   package Real_Arrays is
      new  Ada.Numerics.Generic_Real_Arrays (Real);

   package Julian_Time is new Astro.Generic_Julian_Time (Real);

   use Real_Functions, Real_Arrays;
   use Julian_Time;

   subtype Vector is Real_Vector (1 .. 3);

   ------------------------
   --  Frame operations  --
   ------------------------

   procedure Correct_Aberration
     (U    : in out Vector;          -- geocentric position vector
      VEB  :        Vector);         -- barycentric Earth velocity vector
   --  Correct aberration of light due to motions of body and observer
   --  See ESAA, 1.363

   procedure Correct_Light_Deflection
     (U  : in out Vector;               -- geocentric position vector
      Q  :        Vector;               -- heliocentric position vector
      EH :        Vector);              -- heliocentric position of the Earth
   --  Correct deflection of light due to the gravitational filed of the Sun
   --  See ESAA 1.364

   procedure Precess
     (U    : in out Vector;             -- geocentric position vector
      TDB0 :        Date;               -- initial date (epoch)
      TDB1 :        Date);              -- final date (observation)
   --  Apply precession to position of body
   --  See ESAA 1.35 & 3.21, 3.318

   procedure Nutate
     (U   : in out Vector;              -- geocentric position vector
      JD  :        Date);               -- usually terrestrial time
   --  Apply nutation of celestial frame
   --  See ESAA 1.35 & 3.22, 3.319

   procedure Get_Nutation_Angles
     (JD        :     Date;
      Delta_Psi : out Real;             -- nutation in longitude
      Delta_Eps : out Real);            -- nutation in obliquity
   --  See ESAA 3.225

end Astro.Generic_Frame_Transformations;
