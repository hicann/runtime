#!/bin/bash
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

if [ -z "$ASCEND_HOME_PATH" ]; then
  echo "Error: ASCEND_HOME_PATH environment variable is not set."
  echo "Please set the AscendHome variable by \"source set_env.sh\""
  exit 1
else
  echo "AscendHome is set to: $ASCEND_HOME_PATH"
fi

mkdir ./bin
cd bin
cmake ..
make

./mstx_with_domain