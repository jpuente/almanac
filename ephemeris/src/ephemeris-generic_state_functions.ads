-----------------------------------------------------------------------
-- Ephemeris - Ada library for the JPL ephemerides.                  --
--                                                                   --
-- This package provides basic functions for computing the state     --
-- of solar system bodies from data in a binary ephemerides fil      --
--                                                                   --
-- WARNING:                                                          --
--     This version only works with the DE200 ephemeris              --
-----------------------------------------------------------------------
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Ada.Numerics.Generic_Real_Arrays;

generic

   type Real is digits <>;

   with package Real_Arrays is
     new Ada.Numerics.Generic_Real_Arrays (Real);

   Ephemeris_Code : JPL_Ephemeris := DE200;

package Ephemeris.Generic_State_Functions is
   use Real_Arrays;

   type State is record
      Position : Real_Vector (1 .. 3);
      Velocity : Real_Vector (1 .. 3);
   end record;
   --  Position and velocity are given in rectangular equatorial
   --  coordinates, in AU and AU/day

   function Barycentric_State (Target   : Celestial_Body;
                               Date     : Real)   -- Julian TDB Date
                               return State;
   --  Barycentric position and velocity of the target at given date,
   --  referred to the mean equator and equinox of J2000.0.

   function AU return Real;
   --  Length of an astronomical unit (in meters)

   function EM_Ratio return Real;
   --  Earth_Moon Mass ratio

   function Start_Date return Real;
   --  Initial date for ephemeris data

   function End_Date return Real;
   --  Final date for ephemeris data

   procedure Open_Data (Data_File_Name : String);
   --  Open data file

   procedure Close_Data;
   --  Close data file

end Ephemeris.Generic_State_Functions;
