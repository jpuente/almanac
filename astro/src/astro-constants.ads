-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- This package provides constant definitions.                       --
--                                                                   --
-----------------------------------------------------------------------
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Ada.Numerics;

package Astro.Constants is
   pragma Pure (Astro.Constants);

   --  Constants
   Pi : constant := Ada.Numerics.Pi;
   AU : constant := 0.149597870659999996E+09;  -- Astronomical unit in km
   C  : constant := 299792.458;                -- Light speed in km/s
   Mu : constant := 1.32712438E+20;            -- Heliocentric gravitational
   --                                             constant, m**3/s**2
   EM : constant := 0.813005869999999931E+02;  -- Earth-Moon mass ratio
   R  : constant := 6378.140;                  -- Earth radius in km
   F  : constant := 0.00335281;                -- Earth flattening factor

end Astro.Constants;