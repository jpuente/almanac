<!---
![Alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/euler_tools.json)](https://alire.ada.dev/crates/ephemeris.html)
[![Alire CI/CD](https://img.shields.io/endpoint?url=https://alire-crate-ci.ada.dev/badges/euler_tools.json)](https://alire-crate-ci.ada.dev/crates/euler_tools.html)
![unit-test](https://github.com/rocher/euler_tools/actions/workflows/unit-test.yml/badge.svg)
[![GitHub release](https://img.shields.io/github/release/rocher/euler_tools.svg)](https://github.com/rocher/euler_tools/releases/latest)
[![License](https://img.shields.io/github/license/rocher/euler_tools.svg?color=blue)](https://github.com/rocher/euler_tools/blob/master/LICENSE)
-->

# Ephemeris

 *Ada functions for reading JPL ephemerides of celestial bodies*

Ephemeris is an Ada library for getting ephemerides of celestial bodies
out of a binary file compiled from [JPL ephemerides](https://ssd.jpl.nasa.gov/planets/eph_export.html). The library
currently supports the DE200 ephemeris, which provides enough precision
por celestial navigation computations. 

The distributed version includes a binary ephemeris file (`etc/DE200/DE200`) 
that can be used for the time interval going from 2019-12-15 to 2040-01-07
(Julian dates 2458832.5 to 2466160.5). Other ephemeris data files
can be generated as convenient from ASCII files downloaded
from the JPL server ([https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/](https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/)).
The format of such files is described in 
[https://ssd.jpl.nasa.gov/pub/eph/planets/ascii/ascii_format.txt](https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/ascii_format.txt).
The [`tools` folder](tools/) contains a [`create` tool](tools/create/) that can be used for this purpose. 

The [`docs` folder](docs/) contains more detailed documentation on the design and
use of the Ephemeris library.

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

### Usage

The library is intended to be used in the [astro](URL) library, 
available from [Alire](https://alire.ada.dev).






