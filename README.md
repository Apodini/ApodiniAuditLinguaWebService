<!--

This source file is part of the Apodini open source project

SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>

SPDX-License-Identifier: MIT

-->

# ApodiniAudit Lingua WebService

[![Build](https://github.com/Apodini/ApodiniAuditLinguaWebService/actions/workflows/build.yml/badge.svg)](https://github.com/Apodini/ApodiniAuditLinguaWebService/actions/workflows/build.yml)
[![codecov](https://codecov.io/gh/Apodini/ApodiniAuditLinguaWebService/branch/develop/graph/badge.svg?token=5MMKMPO5NR)](https://codecov.io/gh/Apodini/ApodiniAuditLinguaWebService)

This is an exemplary Web Service which demonstrates ApodiniAudit. ApodiniAudit is a tool to provide feedback on the quality of RESTful APIs built in Apodini. 

## Requirements

When auditing a Web Service using ApodiniAudit, Python & NLTK are used to perform linguistic analysis. Thus, we need to install them before running an audit. This is done automatically when running the tests.

A Python 3 installation is required. Once Python is installed, NLTK and its dependencies can be installed as follows:

```
$ swift build ImprovedApodiniWebService
$ cd .build/debug
$ ./ImprovedLinguaWebService audit setup-nltk
```

## Usage
You can run the Improved Web Service using the following command:
```
$ swift run ImprovedLinguaWebService
```

To run the tests which validate the audits, the report format, and the enforcable best practices, run the following command:

```
$ swift test
```

Alternatively, the tests can be run on various platforms by manually starting the ["Build & Test" workflow](https://github.com/Apodini/ApodiniAuditLinguaWebService/actions/workflows/build.yml).

## License
This project is licensed under the MIT License. See [Licenses](https://github.com/Apodini/Template-Repository/tree/develop/LICENSES) for more information.
