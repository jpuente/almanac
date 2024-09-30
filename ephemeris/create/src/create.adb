-----------------------------------------------------------------------
-- Ephemeris - Ada library for the JPL ephemerides.                  --
--                                                                   --
-- This is the body of the create procedure                          --
--                                                                   --
-- WARNING:                                                          --
--     This version has only been tested with the DE200 ephemeris    --
-----------------------------------------------------------------------
with EPhemeris; use Ephemeris;
with Ephemeris.Generic_Data_File;
with Ephemeris.Generic_Source_File;

with Ada.Command_Line;          use Ada.Command_Line;
with Ada.Directories;           use Ada.Directories;
with Ada.Environment_Variables; use Ada.Environment_Variables;
--  with Ada.Exceptions;            use Ada.Exceptions;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Ada.Text_IO;

procedure Create is

   type Real is new LONG_LONG_FLOAT;
   Ephemeris_Code : JPL_Ephemeris := DE200;

   package Data_File is
     new Ephemeris.Generic_Data_File (Real, Ephemeris_Code);
   use Data_File;

   package Source_File is
     new Ephemeris.Generic_Source_File (Real, Ephemeris_Code, Data_File);

   package Real_IO    is new Ada.Text_IO.Float_IO (Real);
   package Integer_IO is new Ada.Text_IO.Integer_IO (Integer);
   use Ada.Text_IO, Real_IO, Integer_IO;

   --  Ephemeris data

   N_Record   : Natural := 0;
   N, Size    : Natural := 0;

   Parameters : Parameter_Record;
   Data       : Data_Record;

   T0, T1, T2, Last_Date : Real;

   --  File names
   Input_File  : Unbounded_String := Null_Unbounded_String;
   Output_File : Unbounded_String := Null_Unbounded_String;

begin

   ---------------------
   -- Open data files --
   ---------------------
   if Argument_Count > 0 then
      Input_File := To_Unbounded_String (Full_Name (Argument (1)));
   else
      Put_Line ("-- Usage: create source_file [binary_file]");
      Set_Exit_Status (Failure);
      return;
   end if;

   if Argument_Count > 1 then
      Output_File := To_Unbounded_String (Full_Name (Argument (2)));
   elsif Ada.Environment_Variables.Exists ("EPHEMERIS") then
      Output_File := To_Unbounded_String (Value ("EPHEMERIS"));
   elsif Extension (To_String (Input_File)) /= "" then
      Output_File :=
        To_Unbounded_String
          (Compose (Containing_Directory (To_String (Input_File)),
                   Base_Name (To_String (Input_File))));
   else
      Output_File :=
        To_Unbounded_String
          (Compose ("data", JPL_Ephemeris'Image (Ephemeris_Code)));
   end if;

   Source_File.Open (To_String (Input_File));
   Data_File.Create (To_String (Output_File));

   New_Line;
   Put_Line ("Create ephemeris file");
   Put_Line ("   " & To_String (Output_File));
   Put_Line ("from");
   Put_Line ("   " & To_String (Input_File));
   New_Line;

   ---------------------
   -- Read parameters --
   -----------------....

   Source_File.Get_Parameters (Parameters);

   Put ("Start date:      "); Put (Parameters.Start_Date, 8, 1, 0); New_Line;
   Put ("End date:        "); Put (Parameters.End_Date, 8, 1, 0);   New_Line;
   Put ("Interval:        "); Put (Parameters.Interval, 8, 1, 0);   New_Line;
   New_Line;

   --------------------------
   -- Process data records --
   -------------------------

   T1        := Parameters.Start_Date;
   T2        := Parameters.End_Date;
   N_Record  := 0;

   while not Source_File.End_Of_File loop
      Source_File.Get_Data (N, Size, Data);
      --  Set last date for first record.
      if N_Record = 0 then
         Last_Date := Data (1);
      end if;
      --  Skip this data record if the end of the interval is less than
      --  the specified start time or if it does not begin where the
      --  previous block ended.
      if    Data (1) >= Last_Date
        and Data (2) <= T2
        and Data (2) >= T1
      then
         if Data (1) /= Last_Date then
            --  Beginning of current interval is past the end
            --  of the previous one.
            raise Source_File.Error
              with "Gap in record dates";
         end if;
         Last_Date := Data (2);

         N_Record := N_Record + 1;
         --  Save date values of this block.
         if N_Record = 1 then
            Parameters.Start_Date := Data (1);
            T0 := Data (2) - Data (1);
            if T0 /= Parameters.Interval then
               raise Source_File.Error
                 with "Error in date interval";
            end if;
         end if;
         Parameters.End_Date := Data (2);

         if N_Record mod 20 = 0 then
            Put (" ... processing record "); Put (N_Record, 4);
            Put (" ending on "); Put (Parameters.End_Date, 8, 1, 0);
            New_Line;
         end if;
      end if;

      Data_File.Put_Data (N_Record, Data);

   end loop;

   ----------------------------
   -- Write parameter record --
   ----------------------------

   Put (" ... processing headers"); New_Line;
   Data_File.Put_Parameters (Parameters);

   -----------------
   -- Close files --
   -----------------

   Source_File.Close;
   Data_File.Close;

   -------------------
   -- Print summary --
   -------------------

   New_Line;
   Put ("End of conversion; "); Put (N_Record, 0); Put (" records processed.");
   New_Line; New_Line;

end Create;
