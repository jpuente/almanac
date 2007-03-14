with AUnit.Test_Runner;
with Astro_Tests;

procedure Harness is

   procedure Run is new AUnit.Test_Runner (Astro_Tests);

begin
   Run;
end Harness;
