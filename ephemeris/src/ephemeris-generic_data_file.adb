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

with Ada.Direct_IO;
with Ada.Unchecked_Conversion;
with Ada.Exceptions; use Ada.Exceptions;

package body Ephemeris.Generic_Data_File is

   package Binary_IO is new Ada.Direct_IO (Data_Record);
   use Binary_IO;

   ---------------
   -- Data file --
   ---------------

   Data_File : File_Type;

   -------------------
   -- Header record --
   -------------------

   type Byte is mod 256;
   for Byte'Size use 8;

   type Padding is array (Natural range <>) of Byte;
   Slack : constant Natural := (Data_Record'Size - Parameter_Record'Size) / 8;
   pragma Pack (Padding);

   type Header_Record is record
      Parameters : Parameter_Record;
      Trailer    : Padding (1 .. Slack);
   end record;
   pragma Pack (Header_Record);

   function Parsed_Header is
     new Ada.Unchecked_Conversion (Data_Record, Header_Record);
   function Parsed_Data is
      new Ada.Unchecked_Conversion (Header_Record, Data_Record);

   ----------
   -- Open --
   ----------

   procedure Open (File_Name : String) is
   begin
      Open (Data_File, In_File, File_Name);
   exception
      when E : others => raise Data_Error
           with "Cannot open data file " &
                File_Name & Exception_Message (E);
   end Open;

   ------------
   -- Create --
   ------------

   procedure Create (File_Name : String) is
   begin
      Create (Data_File, Out_File, File_Name);
   exception
      when E : others => raise Data_Error
           with "Cannot create data file " &
                File_Name & Exception_Message (E);
   end Create;

   -----------
   -- Close --
   -----------

   procedure Close is
   begin
      if Is_Open (Data_File) then
         Close (Data_File);
      end if;
   exception
      when E : others => raise Data_Error
           with "Cannot close data file " & Exception_Message (E);
   end Close;

   --------------------
   -- Get_Parameters --
   --------------------

   procedure Get_Parameters (Parameters : out Parameter_Record)
   is
      Buffer : Data_Record;
      Header : Header_Record;
   begin
      Read (Data_File, Buffer, 1);
      Header := Parsed_Header (Buffer);
      Parameters := Header.Parameters;
   end Get_Parameters;

   --------------------
   -- Put_Parameters --
   --------------------

   procedure Put_Parameters (Parameters : Parameter_Record)
   is
      Header : Header_Record;
      Buffer : Data_Record;
   begin
      Header.Parameters := Parameters;
      Buffer := Parsed_Data (Header);
      Write (Data_File, Buffer, 1);
   end Put_Parameters;

   --------------
   -- Get_Data --
   --------------

   procedure Get_Data (Record_Number   : Positive;
                       Data            : out Data_Record)
   is
      --  Skip header record
      N : constant Positive_Count := Positive_Count (Record_Number + 1);
   begin
      Read (Data_File, Data, N);
   end Get_Data;

   --------------
   -- Put_Data --
   --------------

   procedure Put_Data (Record_Number   : Positive;
                       Data            : Data_Record)
   is
      --  Skip header record
      N : constant Positive_Count := Positive_Count (Record_Number + 1);
   begin
      Write (Data_File, Data, N);
   end Put_Data;

   -----------------
   -- End_Of_Data --
   -----------------

   function  End_Of_Data return Boolean is
   begin
      return End_Of_File (Data_File);
   end End_Of_Data;

end Ephemeris.Generic_Data_File;
