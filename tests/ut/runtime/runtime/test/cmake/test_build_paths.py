# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[6]


class BuildPathTest(unittest.TestCase):
    def run_build_case(self, option, directory_name, source_name="project"):
        with tempfile.TemporaryDirectory(prefix="runtime-build-path-") as temporary:
            source = Path(temporary) / source_name
            source.mkdir()
            shutil.copyfile(ROOT / "build.sh", source / "build.sh")
            (source / "build.sh").chmod(0o700)
            dependency = Path(temporary) / directory_name
            dependency.mkdir()
            (source / "CMakeLists.txt").write_text(
                "cmake_minimum_required(VERSION 3.14)\n"
                "project(BuildArgumentProbe NONE)\n"
                "foreach(key IN ITEMS CANN_3RD_LIB_PATH ASCEND_INSTALL_PATH CUSTOM_SIGN_SCRIPT CMAKE_INSTALL_PREFIX)\n"
                '  file(WRITE "${CMAKE_BINARY_DIR}/${key}.txt" "${${key}}")\n'
                "endforeach()\n"
                "set(CPACK_GENERATOR TGZ)\n"
                "include(CPack)\n"
            )
            env = os.environ.copy()
            env.pop("ASCEND_HOME_PATH", None)
            result = subprocess.run(
                [
                    str(source / "build.sh"),
                    f"{option}={dependency}",
                    "--build_host_only",
                    "-j1",
                ],
                cwd=temporary,
                env=env,
                capture_output=True,
                text=True,
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            key = (
                "ASCEND_INSTALL_PATH"
                if option == "--ascend_install_path"
                else "CANN_3RD_LIB_PATH"
            )
            actual = (source / "build" / f"{key}.txt").read_text()
            self.assertEqual(actual, str(dependency.resolve()))
            self.assertEqual(
                (source / "build/CMAKE_INSTALL_PREFIX.txt").read_text(),
                str(source / "build_out"),
            )

    def test_plain_dependency_path(self):
        self.run_build_case("--cann_3rd_lib_path", "third_party")

    def test_dependency_path_with_spaces(self):
        self.run_build_case("--cann_3rd_lib_path", "third party")

    def test_dependency_alias_with_spaces(self):
        self.run_build_case("--ascend_3rd_lib_path", "third party alias")

    def test_install_path_with_spaces(self):
        self.run_build_case("--ascend_install_path", "cann install")

    def test_source_and_dependency_paths_with_spaces(self):
        self.run_build_case("--cann_3rd_lib_path", "third party", "project with spaces")


if __name__ == "__main__":
    unittest.main()
