-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  This package provides abstractions for Julian time.              --
-----------------------------------------------------------------------
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

package body Astro.Generic_Julian_Time is
   use Ada.Calendar;

   --  Reference : Fliegel & Van Flandern, Comm. ACM. vol. 11, no. 10,
   --              October 1968, pg. 657.
   --  Also in Explanatory Supplement to the Nautical Almanach, 12.9.

   -------------
   -- Date_Of --
   -------------

   function Date_Of (T : Ada.Calendar.Time) return Date is

      D      : Day_Number;
      M      : Month_Number;
      Y      : Year_Number;
      S      : Day_Duration;
      JD12H  : Integer;
      JD     : Date;

   begin

      Split (T, Y, M, D, S);

      --  Julian date at 12:00 UT
      JD12H :=  1461 * (Y + 4800 + (M - 14) / 12) / 4
        + 367 * (M - 2 - (M - 14) / 12 * 12) / 12
        - 3 * ((Y + 4900 + (M - 14) / 12) / 100) / 4
        + D - 32075;

      --  Julian date at T
      JD := Date (JD12H) + Date (S / 86_400.0) - 0.5;

      return JD;

   end Date_Of;

   -------------
   -- Time_Of --
   -------------

   function Time_Of (D : Date) return Ada.Calendar.Time is

      NJD     : Integer;                           -- number of Julian days

      Year    : Year_Number;
      Month   : Month_Number;
      Day     : Day_Number;
      Seconds : Day_Duration;

      K, M, N : Integer;

   begin

      NJD     := Integer (D);              -- rounded to the nearest integer
      Seconds := Duration ((D + 0.5 - Date (NJD)) * 86_400.0);

      K := NJD + 68569;
      N := 4 * K / 146097;

      K := K - (146097 * N + 3) / 4;
      M := 4000 * (K + 1) / 1461001;
      K := K - 1461 * M / 4 + 31;

      Month := 80 * K / 2447;
      Day   := K - 2447 * Month / 80;
      K     := Month / 11;
      Month := Month + 2 - 12 * K;
      Year  := 100 * (N - 49) + M + K;

      return Time_Of (Year, Month, Day, Seconds);
   end Time_Of;

end Astro.Generic_Julian_Time;
