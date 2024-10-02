-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit.Test_Suites;

package Astro_Test_Suite is

   function Suite return AUnit.Test_Suites.Access_Test_Suite;

end Astro_Test_Suite;