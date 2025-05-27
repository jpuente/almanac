# Ephemeris create

[![Alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/ephemeris.json)](https://alire.ada.dev/crates/ephemeris.html)
[![GitHub release](https://img.shields.io/github/release/jpuente/ephemeris.svg)](https://github.com/jpuente/ephemeris/releases/latest)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

>*Create a binary ephemeris file*

The `create` utility creates a binary ephemeris file
from an ascii file downloaded from the [JPL ephemeris server](https://ssd.jpl.nasa.gov/ftp/eph/planets/ascii/).

---

### Build

To compile and build the program:
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
bin/create DE2020.200 DE2020
```

and `data file` is the binary ephemeris file to be tested.

### Warning

The ascii file (`DE2020.200` in the example above) may contain double precision real numbers in fortran
exponential format, which cannot be read by the `create` utility. In order to prevent errors, the ascii
file must be manually edited so that all `D` exponent marks in real numbers are replaced with `E` exponent marks.
For example, the data line

```sh
0.245883250000000000D+07  0.245886450000000000D+07 -0.468233915556882322D+08
```

must be replaced with

```sh
0.245883250000000000E+07  0.245886450000000000E+07 -0.468233915556882322E+08
```

This can easily be done with a text editor or with the unix command

```sh
sed -E 's/D(\+|\-)/E\1/g' original_file > edited_file
```

### Acknowledgement

The create utility is based on the `asc2eph` program included in
the JPL ephemeris export package. 









