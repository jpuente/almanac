-----------------------------------------------------------------------
-- Ephemeris - Ada library for the JPL ephemerides.                  --
--                                                                   --
-- test [test_file] [ephemeris_file]                         --
--                                                                   --
-- This program tests a binary ephemeris file using a test data file --
-- provided by JPL.                                                  --
-- If no ephemeris file name is provided, one is automatically       --
-- generated in the following way:                                   --
-- 1) If the EPHEMERIS environment variable is defined, its value is --
--    used as the binary file name.                                  --
-- 2) Otherwise, the ephemeris number (DE200) is used as the binary  --
--    file  name.                                            --
--                                                                   --
--  See https://ssd.jpl.nasa.gov/planets/eph_export.html for more    --
--  information on JPL ephemeris files.                              --
-----------------------------------------------------------------------
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Ephemeris; use Ephemeris;
with Ephemeris.Generic_State_Functions;

with Resources;
with Test_Config;

with Ada.Text_IO;

procedure Test is

   type Real is new Long_Long_Float;
   Ephemeris_Code : constant JPL_Ephemeris := DE200;

   package State_Functions is
     new Ephemeris.Generic_State_Functions (Real, Ephemeris_Code);
   use State_Functions;

   package Test_Resources is new Resources (Test_Config.Crate_Name);

   package Real_IO    is new Ada.Text_IO.Float_IO (Real);
   package Integer_IO is new Ada.Text_IO.Integer_IO (Integer);
   use Ada.Text_IO, Real_IO, Integer_IO;

   Test_File_Name : constant String
      := Test_Resources.Resource_Path & "testpo.200";
   Data_File_Name : constant String
      := Test_Resources.Resource_Path & "de200.dat";
   Test_File      : File_Type;

   Test_Data_Name : constant String := "testpo.200";
   Ephemeris_Name : constant String := JPL_Ephemeris'Image (Ephemeris_Code);

   Tag    : String (1 .. 3);  -- test file tags
   Eph_No : String (1 .. 3);  -- ephemeris number in test file records
   Date   : String (1 .. 12); -- calendar date
   JED    : Real;             -- Julian Ephemeris date
   Target : Natural;          -- Target object (1..11)
   Center : Natural;          -- Center object (1..11)
   Coordinate : Natural;      -- Coordinate number (1..6), position comes first
   XI, XE  : Real;            -- Coordinate value
   Diff   : Real;             -- difference

   XT, XC  : State;           -- state of target and center

   Line   : Natural  := 0;
   NOUT   : constant := 10;   -- ouput results every NOUT lines
   OK     : Boolean  := True; -- global result of the test

begin

   --  Write header and start test
   Put ("*** Test JPL Ephemeris " & Ephemeris_Name &
    " *** with " & Test_Data_Name & " test data"); New_Line;
   --  Put ("*** Test file          " & Test_File_Name & " ***"); New_Line;
   --  Put ("*** Data file          " & Data_File_Name & " ***"); New_Line;

   Open (Test_File, In_File, Test_File_Name);
   Open_Data (Data_File_Name);

   --  Start and end dates
   Put ("Start date = ");    Put (Start_Date, 8, 1, 0);
   Put (" --- End date = "); Put (End_Date,   8, 1, 0);
   New_Line (2);

   Put_Line (" line -- jed --   t#   c#   x#   --- jpl value ---" &
            "  --- user value ---    -- difference --");
   loop
      Get (Test_File, Tag); Skip_Line (Test_File);
      exit when Tag = "EOT";
   end loop;

   --  Execute test

   while not End_Of_File (Test_File) loop
      --  get test data
      Get (Test_File, Eph_No);
      if "DE" & Eph_No /= Ephemeris_Name then
         raise Ephemeris_Error
           with "Wrong ephemeris number";
      end if;

      Get (Test_File, Date);
      Get (Test_File, JED);
      Get (Test_File, Target);
      Get (Test_File, Center);
      Get (Test_File, Coordinate);
      Get (Test_File, XI);
      Skip_Line (Test_File);

      --  check data
      if JED >= Start_Date and then JED <= End_Date
        and then Target in 1 .. 11 and then Center in 1 .. 11
      then
         XT := Barycentric_State (Celestial_Body'Val (Target - 1), JED);
         XC := Barycentric_State (Celestial_Body'Val (Center - 1), JED);
         if Coordinate in 1 .. 3 then    -- position component
            XE := XT.Position (Coordinate) - XC.Position (Coordinate);
         elsif Coordinate in 4 .. 6 then -- velocity component
            XE := XT.Velocity (Coordinate - 3) - XC.Velocity (Coordinate - 3);
         else
            raise Ephemeris_Error
                 with "Bad coordinate number";
         end if;
         Diff := abs (XI - XE);
         --  write data
         Line := Line + 1;
         if Diff >= 1.0E-13 then
            OK := False;
            Put_Line ("*** Warning : difference > 1.0E-13 in next line ***");
            Put (Line, 5); Put (JED, 8, 1, 0);
            Put (Target, 5); Put (Center, 5); Put (Coordinate, 5);
            Put (XI, 13, 6, 0); Put (XE, 13, 6, 0); Put (Diff, 13, 6, 0);
            New_Line;
         end if;
         if Line mod NOUT = 0 then
            Put (Line, 5); Put (JED, 8, 1, 0);
            Put (Target, 5); Put (Center, 5); Put (Coordinate, 5);
            Put (XI, 13, 6, 0); Put (XE, 13, 6, 0); Put (Diff, 13, 6, 0);
            New_Line;
         end if;
      end if;
   end loop;

   --  Close files
   Close_Data;
   Close (Test_File);

   if OK then
      Put_Line ("TEST SUCEEDED");
   else
      Put_Line ("TEST FAILED -- see details above");
   end if;
   Put_Line ("*** End of test *** ");
end Test;