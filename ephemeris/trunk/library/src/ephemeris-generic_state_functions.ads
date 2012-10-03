--  $Id$
-----------------------------------------------------------------------
-- Ephemeris - Ada 2005 library for the JPL ephemerides              --
--                                                                   --
-- This package provides basic functions for computing the state     --
-- of solar system bodies.                                           --
-- This is a generic version of the package                          --
-----------------------------------------------------------------------
--  Copyright (C) 2006 Juan A. de la Puente  <jpuente@dit.upm.es>    --
--  This unit was originally developed by Juan A. de la Puente.      --
-----------------------------------------------------------------------
-- This library is free software; you can redistribute it and/or     --
-- modify it under the terms of the GNU General ~Public               --
-- License as published by the Free Software Foundation; either      --
-- version 2 of the License, or (at your option) any later version.  --
--                                                                   --
-- This library is distributed in the hope that it will be useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of    --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
-- General Public License for more details.                          --
--                                                                   --
-- You should have received a copy of the GNU General Public         --
-- License along with this library; if not, write to the             --
-- Free Software Foundation, Inc., 59 Temple Place - Suite 330,      --
-- Boston, MA 02111-1307, USA.                                       --
-----------------------------------------------------------------------
with Ada.Numerics.Generic_Real_Arrays;

generic
   type Real is digits <>;
--   with package Real_Functions is
--     new Ada.Numerics.Generic_Elementary_Functions (Real);
   with package Real_Arrays is
     new Ada.Numerics.Generic_Real_Arrays (Real);
   Ephemeris_Code : in JPL_Ephemeris := DE200;

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

   procedure Open_Data (Data_File_Name : in String);
   --  Open data file

   procedure Close_Data;
   --  Close data file

end Ephemeris.Generic_State_Functions;
