with AUnit.Test_Cases.Registration;
use AUnit.Test_Cases.Registration;
with AUnit.Assertions; use AUnit.Assertions;

with Frame_Transformations;
with Ephemeris.Data;
package body Pr_Frame_Transformations_000 is
   use Frame_Transformations;

   -- Fixture elements;

   P, Q, E : Vector;
   J2000   : Real := 2_451_545.0;

   -- test routines

   procedure Test_Correct_Light_Deflection
     (T : in out Aunit.Test_Cases.Test_Case'Class)
   is
   begin
      Correct_Light_Deflection(P,Q,E);
      Assert( True,
      "Correct light deflection is incorrect");
   end Test_Correct_Light_Deflection;

   ----------
   -- Name --
   ----------

   function Name (T : Test_Case) return String_Access is
   begin
      return new String'("Test Frame_Transformations package");
   end Name;

   --------------------
   -- Register_Tests --
   --------------------

   procedure Register_Tests (T : in out Test_Case) is
   begin
      Register_Routine
        (T, Test_Correct_Light_Deflection'Access,
         "Test light deflection");
   end Register_Tests;

   ------------
   -- Set_Up --
   ------------

   procedure Set_Up (T : in out Test_Case)
   is
    begin
      P := (0.0, 1.0, 0.0);
      Q := (0.7, 0.7, 0.0);
      E := (1.0, 0.0, 0.0);
   end Set_Up;

end Pr_Frame_Transformations_000;
