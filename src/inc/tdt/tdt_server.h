/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INC_TDT_TDT_SERVER_H
#define INC_TDT_TDT_SERVER_H

#include <list>
#include "tdt/status.h"

namespace tdt {
/**
* @ingroup TDTServerInit
* @brief Initialization functions, establish TDT Server,
* provide services such as access services, initialization and tuning channels
*
* @par Function
* Initialization functions, establish TDT Server,
* provide services such as access services, initialization and tuning channels
*
* @param deviceID [IN] type #unsigned int. Physical device ID
* @param bindCoreList [IN] type #List<unsigned int> bindCoreList.
* device CPU core sequence, the maximum value of the core sequence should not
* exceed the total number of CPU cores
* @retval 0 Success
* @retval OtherValues 0 Fail
*
* @par Dependency
* @li libtdtserver.so: Library to which the interface belongs.
* @li tdt_server.h: Header file where the interface declaration is located.
*/
TDT_LIB_EXPORT int32_t TDTServerInit(const uint32_t deviceID, const std::list<uint32_t> &bindCoreList);

/**
* @ingroup TDTServerInit
* @brief End TDT Server
*
* @par Function
* End TDT Server
*
* @param NA
* @retval 0 Success
* @retval OtherValues 0 Fail
*
* @par Dependency
* @li libtdtserver.so: Library to which the interface belongs.
* @li tdt_server.h: Header file where the interface declaration is located.
*/
TDT_LIB_EXPORT int32_t TDTServerStop();

class TdtServer {
 public:
 private:
  /**
  * @ingroup TdtServer
  * @brief TdtServer is a static class, all delete constructs and destructors
  */
  TdtServer() = delete;

  /**
  * @ingroup TdtServer
  * @brief TdtServer destructor
  */
  virtual ~TdtServer() = delete;
  TdtServer(const TdtServer &) = delete;
  TdtServer(TdtServer &&) = delete;
  TdtServer &operator=(const TdtServer &) = delete;
  TdtServer &operator=(TdtServer &&) = delete;
};
};      // namespace tdt
#endif  // INC_TDT_TDT_SERVER_H
