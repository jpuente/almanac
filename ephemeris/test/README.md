# Ephemeris test

[![Alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/ephemeris.json)](https://alire.ada.dev/crates/ephemeris.html)
[![GitHub release](https://img.shields.io/github/release/jpuente/ephemeris.svg)](https://github.com/jpuente/ephemeris/releases/latest)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

>*Test the `Ephemeris` library packages*

The test compares the output of the `Barycentric_State` function 
(position and velocity of a celestial body in a solar system
barycentric reference frame) with the values stored in a 
reference file (by default `testpo.200`). If the difference is larger than
10<sup>-13</sup> in units of AU or AU/day, an error message is
printed out. A progress message is printed every 100 comparisons.

---
## Build

Use Alire to compile and build the tests:

```sh
cd test
alr build
```

---
## Run the test

Run the test using Alire:

```sh
alr run
```

---
## Data

The test program uses two data files:

- The text file `share/test/testpo.200` has been downloaded from the
JPL server ([https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/](https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/)).

- The binary data file `share/test/de200.dat` is a copy of `ephemeris/share/ephemeris/de200.dat`,
which in turn has been generated from ascii files downloaded from
the JPL server ([https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/](https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/)).

---
## License
This software is distributed under a [GPL version 3.0 license](https://www.gnu.org/licenses/gpl-3.0.html).
See LICENSE for more information.

---
## Contact

Juan A. de la Puente <juan.de.la.puente@upm.es>.

This library is part of the [Almanac project](https://github.com/jpuente/almanac/).

---
### Acknowledgement

The test utility is based on the `testeph` program included in
the JPL ephemeris export package. 









