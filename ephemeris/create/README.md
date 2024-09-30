<!---
![Alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/euler_tools.json)](https://alire.ada.dev/crates/ephemeris.html)
[![Alire CI/CD](https://img.shields.io/endpoint?url=https://alire-crate-ci.ada.dev/badges/euler_tools.json)](https://alire-crate-ci.ada.dev/crates/euler_tools.html)
![unit-test](https://github.com/rocher/euler_tools/actions/workflows/unit-test.yml/badge.svg)
[![GitHub release](https://img.shields.io/github/release/rocher/euler_tools.svg)](https://github.com/rocher/euler_tools/releases/latest)
[![License](https://img.shields.io/github/license/rocher/euler_tools.svg?color=blue)](https://github.com/rocher/euler_tools/blob/master/LICENSE)
-->

# Ephemeris create

 *Create a binary ephemeris file*

The `create` utility creates a binary ephemeris file to be used
with the Ephemeris library from an asci file downloaded from
the [JPL ephemeris server](https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/).

---

### Build

To compile and build the unit tests:
```sh
cd create
alr build
```

### Create a binary file

```sh
./bin/create source_file [binary_file]
```

where `test_file` is the ascii file file to be converted.
A header file, also downloaded from the server, must be prefixed 
to the original ascii file, e.g.

```sh
cat header.200 ascp2020.200 > DE2020.200
bin/create DE2020.200 DE200
```

and `data file` is the binary ephemeris file to be tested.

### Acknowledgement

The create utility is based on the `asc2eph` program included in
the JPL ephemeris export package. 









