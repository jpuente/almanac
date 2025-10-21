-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Julian_Time_Tests;             use Julian_Time_Tests;
with Dynamical_Time_Tests;          use Dynamical_Time_Tests;
with Terrestrial_Time_Tests;        use Terrestrial_Time_Tests;
with Sidereal_Time_Tests;           use Sidereal_Time_Tests;
with Frame_Transformations_Tests;   use Frame_Transformations_Tests;
with Geographic_Coordinates_Tests;  use Geographic_Coordinates_Tests;
with Equatorial_Coordinates_Tests;  use Equatorial_Coordinates_Tests;
with Horizontal_Coordinates_Tests;  use Horizontal_Coordinates_Tests;
with Spherical_Coordinates_Tests;   use Spherical_Coordinates_Tests;
with Solar_System_Tests;            use Solar_System_Tests;

package body Astro_Test_Suite is
   use AUnit.Test_Suites;

   Result : aliased Test_Suite;

   Julian_Time_Tests            : aliased Julian_Time_Test_Case;
   Dynamical_Time_Tests         : aliased Dynamical_Time_Test_Case;
   Terrestrial_Time_Tests       : aliased Terrestrial_Time_Test_Case;
   Sidereal_Time_Tests          : aliased Sidereal_Time_Test_Case;
   Frame_Transformation_Tests   : aliased Frame_Transformations_Test_Case;
   Geographic_Coordinates_Tests : aliased Geographic_Coordinates_Test_Case;
   Equatorial_Coordinates_Tests : aliased Equatorial_Coordinates_Test_Case;
   Horizontal_Coordinates_Tests : aliased Horizontal_Coordinates_Test_Case;
   Spherical_Coordinates_Tests  : aliased Spherical_Coordinates_Test_Case;
   Solar_System_Tests           : aliased Solar_System_Test_Case;

   function Suite return Access_Test_Suite is
   begin
      Add_Test (Result'Access, Julian_Time_Tests'Access);
      Add_Test (Result'Access, Dynamical_Time_Tests'Access);
      Add_Test (Result'Access, Terrestrial_Time_Tests'Access);
      Add_Test (Result'Access, Sidereal_Time_Tests'Access);
      Add_Test (Result'Access, Frame_Transformation_Tests'Access);
      Add_Test (Result'Access, Geographic_Coordinates_Tests'Access);
      Add_Test (Result'Access, Equatorial_Coordinates_Tests'Access);
      Add_Test (Result'Access, Horizontal_Coordinates_Tests'Access);
      Add_Test (Result'Access, Spherical_Coordinates_Tests'Access);
      Add_Test (Result'Access, Solar_System_Tests'Access);
      return Result'Access;
   end Suite;

end Astro_Test_Suite;
