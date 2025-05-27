-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- This package provides a framework for the instantiation of        --
-- the Astro library components for a particular floating point type --
--  and ephemeris source.                                            --
-----------------------------------------------------------------------
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Astro.Generic_Julian_Time;
with Astro.Generic_Frame_Transformations;
with Ada.Numerics.Generic_Elementary_Functions;
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
        Real_Functions,
        Real_Arrays,
        Julian_Time);

end Astro.Framework;