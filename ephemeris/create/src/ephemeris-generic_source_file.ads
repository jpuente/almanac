-----------------------------------------------------------------------
-- Ephemeris - Ada library for the JPL ephemerides.                  --
--                                                                   --
-- WARNING:                                                          --
--     This version has only been tested with the DE200 ephemeris    --
-----------------------------------------------------------------------
with Ephemeris.Generic_Data_File;
generic
   type Real is digits <>;
   Ephemeris_Code : JPL_Ephemeris := DE200;
   with package Data_File is
     new Ephemeris.Generic_Data_File (Real, Ephemeris_Code);

package Ephemeris.Generic_Source_File is
   use Data_File;

   Error : exception;

   -------------------------------
   -- Open and close procedures --
   -------------------------------

   procedure Open (File_Name : String);
   --  Open source file. Error is raised if the file cannot be opened.

   procedure Close;
   --  Close source file.

   ----------------------------
   -- Data access procedures --
   ----------------------------

   --  The following subprograms are to be called in sequence.
   --  Error is raised if a data format error is found.

   procedure Get_Parameters (Parameters : out Parameter_Record);

   procedure Get_Data   (Record_Number   : out Natural;
                         Record_Size     : out Natural;
                         Data            : out Data_Record);

   -----------------
   -- End of file --
   -----------------

   function  End_Of_File return Boolean;

end Ephemeris.Generic_Source_File;
