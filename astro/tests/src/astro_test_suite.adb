-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Julian_Time_Tests;             use Julian_Time_Tests;
with Sidereal_Time_Tests;           use Sidereal_Time_Tests;
with Frame_Transformations_Tests;   use Frame_Transformations_Tests;
with Coordinates_Tests;             use Coordinates_Tests;

package body Astro_Test_Suite is
   use AUnit.Test_Suites;

   Result : aliased Test_Suite;

   Julian_Time_Tests          : aliased Julian_Time_Test_Case;
   Sidereal_Time_Tests        : aliased Sidereal_Time_Test_Case;
   Frame_Transformation_Tests : aliased Frame_Transformations_Test_Case;
   Coordinate_Tests           : aliased Coordinates_Test_Case;

   function Suite return Access_Test_Suite is
   begin
      Add_Test (Result'Access, Julian_Time_Tests'Access);
      Add_Test (Result'Access, Sidereal_Time_Tests'Access);
      Add_Test (Result'Access, Frame_Transformation_Tests'Access);
      Add_Test (Result'Access, Coordinate_Tests'Access);
      return Result'Access;
   end Suite;

end Astro_Test_Suite;
