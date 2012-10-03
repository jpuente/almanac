--  $Id$
-----------------------------------------------------------------------
-- Ada utilities for the JPL ephemerides                             --
--                                                                   --
-- This package is the root of the hierarchy for the create          --
-- utility. It can be used to create a binary ephemeris file         --
-- from an ASCII file that can be downloaded from the JPL site       --
-- (see http://ssd.jpl.nasa.gov/).                                   --
--                                                                   --
-- WARNING:                                                          --
--     This version has only been tested with the DE200 ephemeris    --
-----------------------------------------------------------------------
--  Copyright (C) 2006 Juan A. de la Puente  <jpuente@dit.upm.es>    --
--  This unit was originally developed by Juan A. de la Puente.      --
-----------------------------------------------------------------------
-- This program is free software; you can redistribute it and/or     --
-- modify it under the terms of the GNU General Public               --
-- License as published by the Free Software Foundation; either      --
-- version 2 of the License, or (at your option) any later version.  --
--                                                                   --
-- This program is distributed in the hope that it will be useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of    --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
-- General Public License for more details.                          --
--                                                                   --
-- You should have received a copy of the GNU General Public         --
-- License along with this library; if not, write to the             --
-- Free Software Foundation, Inc., 59 Temple Place - Suite 330,      --
-- Boston, MA 02111-1307, USA.                                       --
-----------------------------------------------------------------------
with Ephemeris, Ephemeris.Create;
use Ephemeris;

procedure Create_Ephemeris is
  new Ephemeris.Create (Long_Long_Float, DE200);
