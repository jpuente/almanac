-----------------------------------------------------------------------
-- Ephemeris - Ada 2005 library for the JPL ephemerides.             --
--                                                                   --
-- This package provides access to ephemeris source files.           --
--                                                                   --
-- WARNING: This version only supports the DE200 ephemeris           --
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
with Ada.Text_IO;
with Ada.Characters.Handling,
     Ada.Strings,
     Ada.Strings.Maps,
     Ada.Strings.Maps.Constants,
     Ada.Strings.Fixed;

package body Ephemeris.Generic_Source_File is

   package Integer_IO is new Ada.Text_IO.Integer_IO(Integer);
   package Real_IO    is new Ada.Text_IO.Float_IO(Real);

   use Ada.Text_IO, Integer_IO, Real_IO;
   --use Data_Types;

   -------------------------
   -- Internal data types --
   -------------------------

   Max_Constants : constant := 400;

   subtype Constant_Index is Positive range 1..Max_Constants;
   subtype Constant_Name is String (1..6);

   type Name_Table  is array (Constant_Index) of Constant_Name;
   type Value_Table is array (Constant_Index) of Real;

   -----------------
   -- Global data --
   -----------------

   Input       : File_Type;
   KSize       : Natural;    -- Size of data record in source file
   NCoef       : Natural;    -- No. of coefficientes in data record
   N_Constants : Natural;    -- No. of astronomical constants

   -- internal procedures

   procedure Get_Tag (Tag : String);
   procedure Skip_Numbers;
   procedure Skip_Blanks;
   procedure Adjust (S : in out String; Last : Natural);

   ----------
   -- Open --
   ----------

   procedure Open (File_Name : String) is
   begin
      Open (Input, In_File, File_Name);
   exception
      when Name_Error =>
         raise Error with "Could not open input file " & File_Name;
   end Open;

   -----------
   -- Close --
   -----------

   procedure Close is
   begin
      if Is_Open (Input) then
         Close (Input);
      end if;
   end Close;

   -----------------
   -- Get_Parameters --
   -----------------

   procedure Get_Parameters (Parameters : out Parameter_Record)
   is
      --use Integer_IO, Real_IO;
      Length : Natural := 0;
      N1, N2 : Natural := 0;

      Buffer          : String (1..80);
      Constant_Names  : Name_Table;
      Constant_Values : Value_Table;
   begin
      -- start of source file
      Get_Tag ("KSIZE=");  Get(Input,KSize);
      Get_Tag ("NCOEFF="); Get(Input,NCoef);
      if NCoef /= Data_Record_Size then
         raise Error
           with "Inconsistent record size";
      end if;
      -- read group 1010
      Get_Tag ("GROUP"); Get_Tag("1010"); Skip_Blanks;
      Get_Line (Input, Buffer, Length); -- title
      Get_Line (Input, Buffer, Length); -- start epoch
      Get_Line (Input, Buffer, Length); -- end epoch
      -- read group 1030
      Get_Tag ("GROUP"); Get_Tag("1030"); Skip_Blanks;
      Get(Input, Parameters.Start_Date);
      Get(Input, Parameters.End_Date);
      Get(Input, Parameters.Interval);
      -- read group 1040
      Get_Tag("GROUP"); Get_Tag("1040"); Skip_Blanks;
      Get(Input,N1);  -- number of constant names
      for I in 1..N1 loop
         Skip_Blanks;
         Get(Input, Constant_Names(I));
      end loop;
      -- read group 1041
      Get_Tag("GROUP"); Get_Tag("1041"); Skip_Blanks;
      Get(Input,N2);
      if N2 = N1 then
         N_Constants := N1;
      else
         raise Error
           with "Inconsistency in number of constants";
      end if;
      for I in 1..N2 loop
         Skip_Blanks;
         Get(Input,Constant_Values(I));
      end loop;
      Skip_Numbers;

      for I in 1..N_Constants loop
         if Constant_Names(I) = "AU    " then
            Parameters.AU := Constant_Values(I);
         elsif Constant_Names(I) = "EMRAT " then
            Parameters.EM_Ratio := Constant_Values(I);
         end if;
      end loop;

      -- read group 1050
      Get_Tag("GROUP"); Get_Tag("1050"); Skip_Blanks;
      for I in 1..3 loop
         for J in 1..13 loop
            Get(Input,Parameters.Pointers(I,J));
         end loop;
      end loop;
      -- advance to start of data
      Get_Tag("GROUP"); Get_Tag("1070"); Skip_Blanks;
   end Get_Parameters;

   --------------
   -- Get_Data --
   --------------

   procedure Get_Data
     (Record_Number   : out Natural;
      Record_Size     : out Natural;
      Data            : out Data_Record)
   is
      use Integer_IO, Real_IO;
   begin
      Get(Input,Record_Number);
      Get(Input,Record_Size);
      if Record_Size /= Data'Length then
         raise Error
           with "Inconsistent record size";
      end if;
      for I in 1..Record_Size loop
         Get(Input,Data(I));
      end loop;
      Skip_Numbers;
      Skip_Blanks;
   end Get_Data;

   -----------------
   -- End_Of_File --
   -----------------

   function End_Of_File return Boolean is
   begin
      return End_Of_File(Input);
   end End_Of_File;

   -------------------------
   -- Internal procedures --
   -------------------------

   procedure Get_Tag (Tag : String) is
      Text : String(Tag'Range);
   begin
      Skip_Blanks;
      Get(Input, Text);
      if Text /= Tag then
         raise Error
           with "Expected tag "&Tag& "not found";
      end if;
   end Get_Tag;

   procedure Skip_Blanks is
      use Ada.Characters.Handling;
      C   : Character;
      EOL : Boolean;
   begin
      loop
         Look_Ahead(Input, C, EOL);
         exit when not EOL
           and then (Is_Graphic(C) and C /= ' ');
         if EOL then
            Skip_Line(Input);
         else
            Get(Input,C);
         end if;
      end loop;
   exception
      when End_Error => return;
   end Skip_Blanks;

   procedure Skip_Numbers is
      use Ada.Strings.Maps, Ada.Strings.Maps.Constants;
      C      : Character;
      EOL    : Boolean;
      Number : Character_Set := Decimal_Digit_Set or To_Set(".E+- ");
   begin
      Skip_Blanks;
      loop
         Look_Ahead(Input,C,EOL);
         exit when EOL or else not Is_In(C,Number);
         if EOL then
            Skip_Line(Input);
         else
            Get(Input,C);
         end if;
      end loop;
   exception
      when End_Error => return;
   end Skip_Numbers;

   procedure Adjust (S : in out String; Last : Natural) is
      use Ada.Strings.Fixed;
   begin
      Delete (S, Last+1, S'Last);
   end Adjust;

end Ephemeris.Generic_Source_File;
