with AUnit.Test_Suites; use AUnit.Test_Suites;
with Pr_Julian_Time_000;
with Pr_Frame_Transformations_000;
with Pr_Sidereal_Time_000;

function Astro_Tests return Access_Test_Suite is
   Result : Access_Test_Suite := new Test_Suite;
begin
   Add_Test (Result, new Pr_Julian_Time_000.Test_Case);
   Add_Test (Result, new Pr_Frame_Transformations_000.Test_Case);
   Add_Test (Result, new Pr_Sidereal_Time_000.Test_Case);
   return Result;
end Astro_Tests;
