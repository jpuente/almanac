-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Julian_Time_Tests;             use Julian_Time_Tests;
with Sidereal_Time_Tests;           use Sidereal_Time_Tests;
with Frame_Transformations_Tests;   use Frame_Transformations_Tests;
with Equatorial_Coordinates_Tests;  use Equatorial_Coordinates_Tests;
with Horizontal_Coordinates_Tests;  use Horizontal_Coordinates_Tests;
with Spherical_Coordinates_Tests;   use Spherical_Coordinates_Tests;

package body Astro_Test_Suite is
   use AUnit.Test_Suites;

   Result : aliased Test_Suite;

   Julian_Time_Tests            : aliased Julian_Time_Test_Case;
   Sidereal_Time_Tests          : aliased Sidereal_Time_Test_Case;
   Frame_Transformation_Tests   : aliased Frame_Transformations_Test_Case;
   Equatorial_Coordinates_Tests : aliased Equatorial_Coordinates_Test_Case;
   Horizontal_Coordinates_Tests : aliased Horizontal_Coordinates_Test_Case;
   Spherical_Coordinates_Tests  : aliased Spherical_Coordinates_Test_Case;

   function Suite return Access_Test_Suite is
   begin
      Add_Test (Result'Access, Julian_Time_Tests'Access);
      Add_Test (Result'Access, Sidereal_Time_Tests'Access);
      Add_Test (Result'Access, Frame_Transformation_Tests'Access);
      Add_Test (Result'Access, Equatorial_Coordinates_Tests'Access);
      Add_Test (Result'Access, Horizontal_Coordinates_Tests'Access);
      Add_Test (Result'Access, Spherical_Coordinates_Tests'Access);
      return Result'Access;
   end Suite;

end Astro_Test_Suite;
