-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Ada.Command_Line;
with Ada.Text_IO;

with AUnit.Run;
with AUnit.Reporter.Text;
with AUnit.Test_Results;

with Astro_Test_Suite;
with Astro_Tests_Config; use Astro_Tests_Config;

procedure Astro_Tests is

   procedure Run is new AUnit.Run.Test_Runner_With_Results
     (Astro_Test_Suite.Suite);

   Reporter : AUnit.Reporter.Text.Text_Reporter;
   Results  : AUnit.Test_Results.Result;

begin

   Ada.Text_IO.Put_Line ("Astro library tests");

   pragma Warnings (Off);
   Reporter.Set_Use_ANSI_Colors (Build_Profile = development);
   pragma Warnings (On);

   Run (Reporter, Results);

   if not Results.Successful then
      Ada.Command_Line.Set_Exit_Status (1);
   end if;

end Astro_Tests;
