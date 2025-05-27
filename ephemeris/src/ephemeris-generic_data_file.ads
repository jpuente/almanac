-----------------------------------------------------------------------
-- Ephemeris - Ada library for the JPL ephemerides.                  --
--                                                                   --
-- This package provides access to an ephemeris binary file.         --
--                                                                   --
-- WARNING:                                                          --
--     This version only works with the DE200 ephemeris              --
-----------------------------------------------------------------------
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

generic

   type Real is digits <>;
   Ephemeris_Code : JPL_Ephemeris := DE200;

package Ephemeris.Generic_Data_File is

   Record_Size : constant array (JPL_Ephemeris) of Natural
     := (DE200 =>  826,  -- only this ephemeris is supported
         others => 0);   -- other ephemerides are not supported

   Data_Record_Size : constant Natural := Record_Size (Ephemeris_Code);

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
   --  Get parameters from ephemeris file

   procedure Put_Parameters (Parameters : Parameter_Record);
   --  Put parameters into the ephemeris file

   procedure Get_Data (Record_Number   : Positive;
                       Data            : out Data_Record);
   --  Get a data record from ephemeris file

   procedure Put_Data (Record_Number   : Positive;
                       Data            : Data_Record);
   --  Put a data record into ephemeris file

   function  End_Of_Data return Boolean;
   --  True when end of ephemeris file has been reached

end Ephemeris.Generic_Data_File;
