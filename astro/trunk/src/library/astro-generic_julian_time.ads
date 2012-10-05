-----------------------------------------------------------------------
--  Astro - Ada 2005 library for                                     --
--  This package provides abstractions for Julian time.              --
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
with Ada.Calendar;

generic
   type Real is digits <>;
package Astro.Generic_Julian_Time is
   --  Julian time is counted in days from noon on January 1, 4713 BC.
   --  This way of counting time was proposed by J. J. Scaliger
   --  in 1583 and is commonly used in astronomical calculations.

   subtype Date is Real range 0.0 .. 3_000_000.0;

   Epoch : constant Date := 2_451_545.0;   -- J2000.0 epoch

   --  J2000.0 is the julian date 2451545.0 TT (Terrestrial Time),
   --          or 1st January 2000, noon TT
   --          (equivalent to 1st January 2000 11:58:55.816 UTC)

   function Date_Of (T : Ada.Calendar.Time) return Date;
   function Time_Of (D : Date) return Ada.Calendar.Time;
   --  Ada.Calendar.Time is assumed to be UTC

end Astro.Generic_Julian_Time;
