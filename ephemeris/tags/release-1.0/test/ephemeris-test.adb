-----------------------------------------------------------------------
-- Ephemeris - Ada 2005 utilities for the JPL ephemerides.           --
--                                                                   --
-- test_ephemeris test_file [ephemeris_file]                         --
--                                                                   --
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
with Ephemeris.Generic_State_Functions;

with Ada.Numerics,
     Ada.Numerics.Generic_Elementary_Functions,
     Generic_Real_Arrays;

with Ada.Text_IO;
with Ada.Command_Line;          use Ada.Command_Line;
with Ada.Environment_Variables; use Ada.Environment_Variables;
with Ada.Directories;           use Ada.Directories;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;

procedure Ephemeris.Test is

  package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);
   package Real_Arrays is
     new Generic_Real_Arrays (Real);
   package Solar_System is
     new Ephemeris.Generic_State_Functions (Real,
                                            Real_Functions,
                                            Real_Arrays,
                                            Ephemeris_Number);
   use Solar_System;

   package Real_IO    is new Ada.Text_IO.Float_IO(Real);
   package Integer_IO is new Ada.Text_IO.Integer_IO(Integer);
   use Ada.Text_IO, Real_IO, Integer_IO;

   Test_File_Name : Unbounded_String := Null_Unbounded_String;
   Data_File_Name : Unbounded_String := Null_Unbounded_String;
   Test_File      : File_Type;

   Ephemeris_Name : String := JPL_Ephemeris'Image(Ephemeris_Number);

   Tag    : String(1..3); -- test file tags
   Eph_No : String(1..3); -- ephemeris number in test file records (e.g. "200")
   Date   : String(1..12);-- calendar date
   JED    : Real;         -- Julian Ephemeris date
   Target : Natural;      -- Target object (1..11)
   Center : Natural;      -- Center object (1..11)
   Coordinate : Natural;  -- Coordinate number (1..6), position comes first
   XI,XE  : Real;         -- Coordinate value
   Diff   : Real;         -- difference

   XT,XC  : State;        -- state of target and center

   Line   : Natural  := 0;
   NOUT   : constant := 10; -- ouput results every NOUT lines

begin
   -- Open data files
   if Argument_Count > 0 then
      Test_File_Name := To_Unbounded_String(Full_Name(Argument(1)));
   else
      Put_Line ("-- Usage: test_ephemeris test_file [data_file]");
      Set_Exit_Status(Failure);
      return;
   end if;

   if Argument_Count > 1 then
      Data_File_Name := To_Unbounded_String(Full_Name(Argument(2)));
   elsif Ada.Environment_Variables.Exists ("EPHEMERIS") then
      Data_File_Name := To_Unbounded_String(Value("EPHEMERIS"));
   else
      Data_File_Name := To_Unbounded_String(Compose("data",Ephemeris_Name));
   end if;

   Open(Test_File, In_File, To_String(Test_File_Name));
   Open_Data(To_String(Data_File_Name));

   -- Write header and start test
   Put("Test JPL Ephemeris " & Ephemeris_Name);
   New_Line;

   Put_Line(" line -- jed --   t#   c#   x#   --- jpl value ---"&
            "  --- user value ---    -- difference --");
   loop
      Get(Test_File,Tag); Skip_Line(Test_File);
      exit when Tag = "EOT";
   end loop;

   -- Execute test

   while not End_Of_File(Test_File) loop
      -- get test data
      Get(Test_File,Eph_No);
      if "DE"&Eph_No /= Ephemeris_Name then
         raise Ephemeris_Error
           with "Wrong ephemeris number";
      end if;

      Get(Test_File,Date);
      Get(Test_File,JED);
      Get(Test_File,Target);
      Get(Test_File,Center);
      Get(Test_File,Coordinate);
      Get(Test_File,XI);
      Skip_Line(Test_File);

      -- check data
      if JED >= Start_Date and JED <= End_Date
        and Target in 1..11 and Center in 1..11 then
         XT := Barycentric_State(Object'Val(Target-1),JED);
         XC := Barycentric_State(Object'Val(Center-1),JED);
         if Coordinate in 1..3 then    -- position component
            XE := XT.Position(Coordinate) - XC.Position(Coordinate);
         elsif Coordinate in 4..6 then -- velocity component
            XE := XT.Velocity(Coordinate-3) - XC.Velocity(Coordinate-3);
         else
            raise Ephemeris_Error
              with "Bad coordinate number";
         end if;
         Diff := abs(XI-XE);
         -- write data
         Line := Line +1;
         if DIFF >= 1.0E-13 then
            Put_Line("*** Warning : difference > 1.0E-13 in next line ***");
            Put(Line,5); Put(JED,8,1,0);
            Put(Target,5); Put(Center,5); Put(Coordinate,5);
            Put(XI,13,6,0);Put(XE,13,6,0);Put(Diff,13,6,0);
            New_Line;
         end if;
         if Line mod NOUT = 0 then
            Put(Line,5); Put(JED,8,1,0);
            Put(Target,5); Put(Center,5); Put(Coordinate,5);
            Put(XI,13,6,0);Put(XE,13,6,0);Put(Diff,13,6,0);
            New_Line;
         end if;
      end if;
   end loop;

   -- Close files
   Close_Data;
   Close(Test_File);

   Put_Line("End of test");

end Ephemeris.Test;
