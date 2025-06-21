# Astro

[![Alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/astro.json)](https://alire.ada.dev/crates/astro.html)
[![GitHub release](https://img.shields.io/github/release/jpuente/astro.svg)](https://github.com/jpuente/astro/releases/latest)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

 *Ada packages for positional astronomy*

 Astro is an Ada library for computing some values used in positional astronomy. The library
 can be used to calculate apparent and topocentric places of solar system bodies, including
 the Sun, Moon, and planets. 

---
## Installation

### Build

Use [Alire](https://alire.ada.dev) to get and compile the library:
```sh
alr get astro
cd astro*
alr build
```

### Tests

To compile and build the unit tests:
```sh
cd tests
alr build
alr run
```

Documentation for the tests can be found in the [README file](tests/README.md) of the tests directory.

---
## Dependencies

The Astro library requires the [Ephemeris](https://alire.ada.dev/crates/ephemeris) library to be installed.

---
## Design

The library is made up of one root package and several generic packages.

### Astro package

- The root component of the library is the `Astro` package,
which contains type definitions for celestial bodies (Sun, Moon, and planets)
and links to the Ephemeris library root.

- The `Astro.Constants` package defines some numerical constants that
are used in other packages of the library.

### Generic packages

The rest of the packages in the library are generic packages that
have to be instantiated with the real type 
to be used for calculations (`Long_Long_Float` is recommended).

- **Time-related packages**

  - `Astro.Generic_Julian_Time` provides abstractions for Julian time, including conversion functions 
to and from calendar time.  

  - `Astro.Generic_Dynamical_Time` provides conversion functions for different time scales: Universal Time (UT),
Terrestrial Dynamical Time (TT), and Barycentric Dynamical Time (TDB).

  - `Astro.Generic_Sidereal_Time` defines two functions providing the values of Greenwich mean and
apparent sidereal times at a given UTC value.  

- **Coordinates packages**

  - `Astro.Generic_Coordinates` is the root of a few packages for handling various kinds of coordinates.

  - `Astro.Generic_Coordinates.Geographic` defines latitude and longitude coordinates for locating
  a position on the Earth surface. The package includes a function for computing the geocentric
  position vector of a point given its geograpic coordinates.

  - `Astro.Generic_Coordinates.Equatorial` defines the equatorial coordinates of a celestial body
  in terms of its declination and hour angle.

  - `Astro.Generic_Coordinates.Horizontal` defines the horizontal coordinates of a celestial body
  in terms of altitude and azimuth, as seen by an observer on the Earth surface. This package
  also includes a conversion function giving th ehorizontal coordinates of a body from its
  equatorial coordinates and the geographic coordinates of the observer.

  - `Astro.Generic_Coordinates` defines the geocentric spherical coordinates of a 
  celestial body, in terms of declination, right ascension and distance from the barycenter of the Earth.

- **Other packages**

  - `Astro.Generic_Frame_Transformations` provides frame transformations fpr position and
  velocity vectors.

  - `Astro.Generic_Solar_System` provides functions for computing apparent and topocentric
  places for solar system bodies at a given time.

---
## License

This library is distributed under a [GPL version 3.0 license](https://www.gnu.org/licenses/gpl-3.0.html).
See the file LICENSE for more information.

---
## Contact

Juan A. de la Puente <juan.de.la.puente@upm.es>.

This library is part of the [Almanac project](https://github.com/jpuente/almanac/).

---
## Acknowledgements

The library is based on the Naval Observatory Vector Astrometry Software (NOVAS), available from 
 the [Astrophysics Source Code Library](https://ascl.net).

---
## References

1. P.K. Seidelmann (ed.). *Explanatory Supplement to the Astronomical Almanac*. 
   University Science Books, 2nd. ed. 1992. 


