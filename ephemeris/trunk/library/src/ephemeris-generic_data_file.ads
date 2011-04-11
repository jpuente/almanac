--  $Id$:
-----------------------------------------------------------------------
-- Ephemeris - Ada 2005 library for the JPL ephemerides.             --
--                                                                   --
-- This package provides access to an ephemeris binary file.         --
-- This is a generic version of the package.                         --
-----------------------------------------------------------------------
--  Copyright (C) 2006 Juan A. de la Puente  <jpuente@dit.upm.es>    --
--  This unit was originally developed by Juan A. de la Puente.      --
-----------------------------------------------------------------------
-- This library is free software; you can redistribute it and/or     --
-- modify it under the terms of the GNU General Public               --
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
generic
   type Real is digits <>;
   Ephemeris_Number : in JPL_Ephemeris := DE200;
package Ephemeris.Generic_Data_File is

   Record_Size : constant array (JPL_Ephemeris) of Positive
     := (DE200 =>  826,
         DE405 => 1018,
         DE406 =>  728);

   Data_Record_Size : constant Positive := Record_Size (Ephemeris_Number);

   -----------------------
   -- Record definition --
   -----------------------

   --  An ephemeris data file is composed of a parameter record and a
   --  number of data records.

   type Data_Record is
     array (Positive range 1 .. Data_Record_Size) of Real;
   --  The first two elements of a data record are the Julian dates of
   --  the first and last components of the record.
   --  Then come the Chebyshev coefficients for the solar system bodies in the
   --  following order: Mercury, Venus, Earth-Moon barycentre, Mars, Jupiter,
   --  Saturn, Uranus, Neptune, Pluto, Moon, and Sun. These are followed by
   --  the coefficients for a pair of nutation angles and, possibly, by the
   --  coefficients for three libration angles for the Moon. The structure of
   --  a data record is defined by the polynomial pointers.
   pragma Pack (Data_Record);

   type Polynomial_Pointers is array (1 .. 3, 1 .. 13) of Natural;
   --  This array defines the structure of a data record. Data records
   --  contain coefficients for Chebyshev polynomial interpolation of
   --  celestial bodies in the time interval defined in the file header.
   --  This time interval may be further subdived into shorter intervals
   --  called "granules".

   --  Pointer (1,I) contains the index, relative to the beginning of a
   --  data record, where the coefficients for body number I begin.
   --  Pointer (2,I) contains the number of coefficients in each granule
   --  for each component of the position vector (i.e. 3).
   --  Pointer (3,I) contains the number of granules in a record for
   --  body I.
   --  pragma Pack(Polynomial_Pointers);

   type Parameter_Record is record
      Start_Date : Real;                -- initial Julian date
      End_Date   : Real;                -- final Julian date
      Interval   : Real;                -- data record interval in days
      Pointers   : Polynomial_Pointers; -- see above
      AU         : Real;                -- astronomical unit in meters
      EM_Ratio   : Real;                -- Earth-Moon mass ratio
   end record;
   --  The parameter record is placed at the beginning of the data file.
   --  It contains basic information anout the ephemeris data, as well
   --  as the values of two astronomical constants that are need to process
   --  the ephemeris data.
   pragma Pack (Parameter_Record);

   -------------------------------
   -- File handling procedures --
   -------------------------------

   procedure Open (File_Name : String);
   --  Open the binary ephemeris file.
   --  Ephemeris_Error is raised if the file cannot be opened.

   procedure Create (File_Name : String);
   --  Create the binary ephemeris file.
   --  Ephemeris_Error is raised if the file cannot be opened.

   procedure Close;
   --  Close the ephemeris file.

   ----------------------------
   -- Data access procedures --
   ----------------------------

   procedure Get_Parameters (Parameters : out Parameter_Record);
   procedure Put_Parameters (Parameters : in  Parameter_Record);

   procedure Get_Data (Record_Number   : in  Positive;
                       Data            : out Data_Record);
   procedure Put_Data (Record_Number   : in  Positive;
                       Data            : in Data_Record);

   function  End_Of_Data return Boolean;

end Ephemeris.Generic_Data_File;
