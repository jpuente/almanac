-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Root package provides for  coordinates.                           --
--                                                                   --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

generic
   type Real is digits <>;
   with package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);
  with package Real_Arrays is
     new Ada.Numerics.Generic_Real_Arrays (Real);

package Astro.Generic_Coordinates is
   pragma Pure (Astro.Generic_Coordinates);

   subtype Degrees is Real;
   subtype Hours   is Real;
   subtype Vector is Real_Arrays.Real_Vector (1 .. 3);

end Astro.Generic_Coordinates;