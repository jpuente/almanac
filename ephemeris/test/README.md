<!---
![Alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/euler_tools.json)](https://alire.ada.dev/crates/ephemeris.html)
[![Alire CI/CD](https://img.shields.io/endpoint?url=https://alire-crate-ci.ada.dev/badges/euler_tools.json)](https://alire-crate-ci.ada.dev/crates/euler_tools.html)
![unit-test](https://github.com/rocher/euler_tools/actions/workflows/unit-test.yml/badge.svg)
[![GitHub release](https://img.shields.io/github/release/rocher/euler_tools.svg)](https://github.com/rocher/euler_tools/releases/latest)
[![License](https://img.shields.io/github/license/rocher/euler_tools.svg?color=blue)](https://github.com/rocher/euler_tools/blob/master/LICENSE)
-->

# Ephemeris test

 *Test of binary ephemeris file*

The test compares the output of the `Barycentric_State` function 
(position and velocity of a celestial body in a solar system
barycentric reference frame) with the values stored in a 
reference file (`testpo.xxx`). If the difference is larger than
10<sup>-13</sup> in units of AU or AU/day, an error message is
printed out. A progress message is printed every 100 comparisons.

---

### Build

To compile and build the unit tests:
```sh
cd test
alr build
```

### Execute the test

```sh
./bin/test test_file [data_file]
```

where `test_file` is the reference file (e.g. `data/testpo200`),
and `data file` is the binary ephemeris file to be tested.
If not provided, `data_file` defaults to `data/DE200`.

### Acknowledgement

The test utility is based on the `testeph` program included in
the JPL ephemeris export package. 









