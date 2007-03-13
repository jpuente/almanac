-----------------------------------------------------------------------
-- Ephemeris - Ada 2005 library for the JPL ephemerides.             --
--                                                                   --
-- This package provides access to ephemeris source files.           --
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
with Ephemeris.Generic_Data_File;
generic
   type Real is digits <>;
   Ephemeris_Number : in JPL_Ephemeris := DE200;
   with package Data_File is
     new Ephemeris.Generic_Data_File (Real, Ephemeris_Number);
package Ephemeris.Generic_Source_File is
   use Data_File;

   Error : exception;

  -------------------------------
   -- Open and close procedures --
   -------------------------------

   procedure Open (File_Name : String);
   -- Open source file. Error is raised if the file cannot be opened.

   procedure Close;
   -- Close source file.

   ----------------------------
   -- Data access procedures --
   ----------------------------

   -- The following subprograms are to be called in sequence.
   -- Error is raised if a data format error is found.

   procedure Get_Parameters (Parameters : out Parameter_Record);

   procedure Get_Data   (Record_Number   : out Natural;
                         Record_Size     : out Natural;
                         Data            : out Data_Record);

   -----------------
   -- End of file --
   -----------------

   function  End_Of_File return Boolean;

end Ephemeris.Generic_Source_File;
