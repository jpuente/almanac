# Ephemeris

[![Alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/ephemeris.json)](https://alire.ada.dev/crates/ephemeris.html)
[![GitHub release](https://img.shields.io/github/release/jpuente/ephemeris.svg)](https://github.com/jpuente/ephemeris/releases/latest)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

 *Ada functions for reading JPL ephemerides of celestial bodies*

Ephemeris is an Ada library for getting ephemerides of celestial bodies
out of a binary file compiled from [JPL ephemerides](https://ssd.jpl.nasa.gov/planets/eph_export.html). The library
currently supports the DE200 ephemeris, which provides enough precision
por celestial navigation computations. 

The library is intended to be used in the [astro](URL) library, 
also available from [Alire](https://alire.ada.dev).

---
## Installation

### Build

Use [Alire](https://alire.ada.dev) to get and compile the library:
```sh
alr get ephemeris
cd ephemeris*
alr build
```

### Test

To compile and build the unit tests:
```sh
cd test
alr build
./bin/test
```

Documentation for the tests is provided [here](test/README.md).

---
## Design

The library is made up of one root package and two generic packages.

### Ephemeris package

The root component of the library is the `Ephemeris` package,
which contains type definitions for different kinds of ephemerides
(although only the DE200 ephemeris is supported in this version),
and for celestial bodies (Sun, Moon, and planets).

### Other packages

Two other packages are included in the Ephemeris library. Both are
generic packages that have to be instantiated for the real type 
to be used (`Long_Long_Float` is recommended) and the code of the
ephemeris (default is `DE200`).

* `Ephemeris.Generic_Data_File` provides operations for accessing
   a binary ephemeris file, including `Create`, `Open`, `Close`, as well
   as `Get` and `Put` operations for parameters and data records. Bot kinds
   of records are defined in the specification of the package.

*  `Ephemeris.Generic_State_functions` defines a type for the state
   of a celestial body. The state consists of the position and velocity
   of the body center of mass, measured in astronomical units
   (AU and AU/s, respectively), in equatorial coordinates with respect 
   to a Solar System barycentric reference frame.

   The function `Barycentric_State` gives the value of the state vector
   of a celestial body at a given Julian date. 

### Data

The distributed version includes a binary ephemeris file (`etc/DE200/ephemeris200`) 
that can be used for the time interval going from 2019-12-15 to 2040-01-07
(Julian dates 2458832.5 to 2466160.5). Other ephemeris data files
can be generated as convenient from ASCII files downloaded
from the JPL server ([https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/](https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/)).
The format of such files is described in 
[https://ssd.jpl.nasa.gov/pub/eph/planets/ascii/ascii_format.txt](https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/ascii_format.txt).
The [`create` folder](create/) contains a tool that can be used for this purpose.  

---
## License

This library is distributed under a [GPL version 3.0 license](https://www.gnu.org/licenses/gpl-3.0.html).
See LICENSE for more information.

---
## Contact

Juan A. de la Puente <juan.de.la.puente@upm.es>.

This library is part of the [Almanac project](https://github.com/jpuente/almanac/).

---
## Acknowledgements

The library uses publicly available ephemeris data 
from the [Jet Propulsion Laboratory Planetary and Lunar Ephemerides](https://ssd.jpl.nasa.gov/planets/eph_export.html) server.

The Ada code is partly based on the Fortran and C software provided at the same server.

---
## References

1. P.K. Seidelmann (ed.). *Explanatory Supplement to the Astronomical Almanac*. 
   University Science Books, 2nd. ed. 1992.
   