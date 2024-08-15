# Copyright 2023 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""A small helper to ensure that we are working with full versions."""

load("//python:versions.bzl", "MINOR_MAPPING")

def full_version(version):
    """Return a full version.

    Args:
        version: the version in `X.Y` or `X.Y.Z` format.

    Returns:
        a full version given the version string. If the string is already a
        major version then we return it as is.
    """
    if version in MINOR_MAPPING:
        return MINOR_MAPPING[version]

    parts = version.split(".")
    if len(parts) == 3:
        return version
    elif len(parts) == 2:
        fail(
            "Unknown Python version '{}', available values are: {}".format(
                version,
                ",".join(MINOR_MAPPING.keys()),
            ),
        )
    else:
        fail("Unknown version format: '{}'".format(version))
