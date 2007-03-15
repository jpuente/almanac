--with Ada.Strings.Unbounded;
--use Ada.Strings.Unbounded;

with AUnit; use AUnit;

package Julian_Time_Test is
   use Test_Results;

   type Test_Case is
     new Test_Cases.Test_Case with null record;

   procedure Register_Tests (T : in out Test_Case);
   --  Register routines to be run

   function Name (T : Test_Case) return Test_String;
   --  Returns name identifying the test case

   -- Test routines:
   procedure Test_Date (T : in out Test_Cases.Test_Case'Class);
   procedure Test_Time (T : in out Test_Cases.Test_Case'Class);

   procedure Set_Up (T : in out Test_Case);
   -- Preparation performed before each test routine

end Julian_Time_Test;
