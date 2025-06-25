----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Apparent and topocentric places of Solar system bodies.           --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, 3.3 (1992)                                  --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Ephemeris.Generic_State_Functions;

with Astro.Constants;
with Astro.Generic_Dynamical_Time;
with Astro.Generic_Sidereal_Time;
with Astro.Generic_Frame_Transformations;

package body Astro.Generic_Solar_System is

   package State_Functions is
      new Ephemeris.Generic_State_Functions (Real);
   package Dynamical_Time is
      new Astro.Generic_Dynamical_Time (Real);
   package Sidereal_Time is new Astro.Generic_Sidereal_Time (Real);

   package Frame_Transformations is
      new Astro.Generic_Frame_Transformations (Real);

--   package Real_Functions renames Frame_Transformations.Real_Functions;
   package Real_Arrays    renames Frame_Transformations.Real_Arrays;
   use Real_Arrays;

   use Ephemeris;
   use Dynamical_Time;

   use Julian;
--   use Coordinates;
   use State_Functions;
   use Frame_Transformations;

   AU : constant := Astro.Constants.AU;  --  km
   C0 : constant := Astro.Constants.C;   --  km/s

   C : constant := C0 / AU * 86400.0;    --  AU/day

   subtype Vector       is Real_Vector (1 .. 3);
   subtype Coordinate_Vector is Spheric.Vector;

   ----------------------
   --  Apparent place  --
   ----------------------

   --  Reference: Explanatory Supplement to the Astronomical Almanac,3.31.

   function Apparent_Place
      (Target : Solar_System_Body;
      TT      : Julian.Date)
         return Spherical_Coordinates
   is

      T0      : constant Date := Epoch; -- J2000.0

      T       : Date;   --  barycentric dynamical time (TDB)
      Tau     : Date;   --  light travel time from target to Earth
                        --  in TDB scale for light arriving at time t

      TBS     : State;  --  Target barycentric state
      UB      : Vector; --  Target barycentric position

      EBS     : State;  --  Earth barycentric state
      EB      : Vector; --  Earth barycentric position
      VEB     : Vector; --  Earth barycentric velocity
      EH      : Vector; --  Earth heliocentric position

      SBS     : State;  --  Sun barycentric state
      SB      : Vector; --  Sun barycentric position

      UH      : Vector; --  Target heliocentric position

      D       : Real;   --  Geometric distance Earth-body (AU)
      T1      : Date;   --  light time (days)

      U       : Vector;    --  Target position.

   begin

      State_Functions.Open_Data;

      --  Compute barycentric time.
      T := TDB (TT);

      --  Get barycentric state of Earth.
      EBS := Barycentric_State (Earth, T);
      EB  := Vector (EBS.Position);

      --  Get barycentric state of Sun.
      SBS := Barycentric_State (Sun, T);
      SB  := Vector (SBS.Position);

      --  Compute heliocentric position of Earth
      EH  := EB - SB;

      --  Get barycentric position of target
      TBS := Barycentric_State (Target, T);
      UB  := Vector (TBS.Position);

      --  Geometric distance between Earth and body
      D := abs (UB - EB);

      --  Compute light time from target to Earth
      --  and compute geocentric position of target.
      Tau := D / C;
      loop
         TBS := Barycentric_State (Target, T - Tau);
         UB  := Vector (TBS.Position);                --  T - Tau
         U   := UB - EB;         --  geocentric position of target
         T1  := abs (U) / C;
         exit when abs (T1 - Tau) <= 1.0E-8;
         Tau := T1;
      end loop;

      --  Comute target heliocentric state
      SBS := Barycentric_State (Sun, T - Tau);
      SB  := Vector (SBS.Position);
      UH  := UB - SB;
      EH  := EB - SB;

      --  Correct for gravitational field deflection.
      if Target /= Sun then
         Correct_Light_Deflection (U, UH, EH);
      end if;

      --  Correct for light aberration
      VEB := Vector (EBS.Velocity);
      Correct_Aberration (U, VEB);

      --  Apply precession.
      Precess (U, T0, T);

      --  Apply nutation.
      Nutate (U, T);

      State_Functions.Close_Data;
      return Spherical (Coordinate_Vector (U));

   end Apparent_Place;

   -------------------------
   --  Topocentric place  --
   -------------------------

   --  Reference: Explanatory Supplement to the Astronomical Almanac,3.35

   function Topocentric_Place
     (Target    : Solar_System_Body;
      JTD       : Julian.Date;                 --  TT
      Position  : Geographic_Coordinates;
      Height    : Real)
      return Spherical_Coordinates
   is
      use Sidereal_Time;

      T0      : constant Date := Epoch; -- J2000.0
      T       : Date;   -- barycentric time
      UT      : Date;   -- universal time
      Theta   : Sidereal_Time.Time; -- apparent sidereal time
      Tau, T1 : Date;   -- light time (days)

      R       : Vector; --  geocentric position of observer (meters)
      EBS     : State;  --  Earth barycentric state
      TBS     : State;         --  Target barycentric state
      EHS     : State;         --  Earth heliocenteric state
      THS     : State;         --  Target heliocentric state

      EH      : Vector;        --  Earth heliocentric position.
      UH      : Vector;        --  Target heliocentric position.
      VB      : Vector;        --  Target barycentric state.

      U       : Vector;

   begin

      State_Functions.Open_Data;

      --  Compute Universal time 
      UT := 0.0; --  TU (JTD); ************************************

      --  Compute geocentric position of observer
      R  := Vector (Geocentric_Position (Position, Height));

      --  Sidereal time in degrees (GHA Aries)
      Theta := GAST (UT) * 360.0 / 86400.0;

      --  Compute barycentric time.
      T  := TDB (JTD);

      --  Get barycentric state of Earth.
      EBS := Barycentric_State (Earth, T);

      --  Compute light time from target to Earth
      --  and compute geocentric position of target.
      Tau := 0.0;
      loop
         TBS := Barycentric_State (Target, T - Tau);
         U   := Vector (TBS.Position) - Vector (EBS.Position);
         T1  := abs (U) / C;
         exit when abs (T1 - Tau) <= 1.0E-8;
         Tau := T1;
      end loop;

      --  Correct for gravitational field deflection.
      if Target /= Sun then
         EHS := Heliocentric_State (Earth, T);
         THS := Heliocentric_State (Target, T - Tau);
         UH  := Vector (THS.Position);
         EH  := Vector (EHS.Position);
         Correct_Light_Deflection (U, UH, EH);
      end if;

      --  Correct for light aberration
      VB := Vector (EBS.Velocity);
      Correct_Aberration (U, VB);

      --  Apply precession.
      Precess (U, T0, T);

      --  Apply nutation.
      Nutate (U, T);

      State_Functions.Close_Data;

      return Spherical (Coordinate_Vector (U));

   end Topocentric_Place;

end Astro.Generic_Solar_System;