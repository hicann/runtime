/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HCCL_EX_H
#define HCCL_EX_H

#include <hccl/base.h>

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

/**
 * @brief Initialize HCCL.
 *
 * @param rankTabelM A rankTableJson string in the memory.
 * @param rank A integer identifying the identify for the rank.
 * @param comm A pointer identifying the initialized communication resource.
 * @return HcclResult
 * @see HcclFinalizeComm()
 */
extern HcclResult HcclInitComm(const char* rankTableM, uint32_t rank, const CommAttr* attr, HcclComm* comm);

/**
 * @brief Destroy HCCL Heterog comm
 *
 * @param comm A pointer identifying the communication resource targetting
 * @return HcclResult
 * @see HcclInitComm()
 */
extern HcclResult HcclFinalizeComm(HcclComm comm);

/**
 * @ingroup mem_manangement
 * @brief MR registed for the whole process
 * @param [in]  addr memory address of the MR
 * @param [in]  byte number of the MR
 * @return HCCL_SUCCESS for ok
 * @return HCCL_E_PARA for error input
 */
extern HcclResult HcclRegisterGlobalMemory(void* addr, u64 size);

/**
 * @ingroup mem_manangement
 * @brief MR unregisted for the whole process
 * @param [in]  addr memory address of the MR
 * @return HCCL_SUCCESS for ok
 * @return HCCL_E_PARA for error input
 */
extern HcclResult HcclUnregisterGlobalMemory(void* addr);

extern HcclResult HcclRegisterMemory(HcclComm comm, void* buffer, uint64_t size);

extern HcclResult HcclUnregisterMemory(HcclComm comm, void* buffer);

extern int HcclIsend(void* buffer, int count, HcclDataType dataType, int dstRank, int tag,
    HcclComm comm, HcclRequest* request);

extern int HcclImrecv(void* buffer, int count, HcclDataType dataType, HcclMessage *msg,
    HcclRequest* request);

extern int HcclImprobe(int srcRank, int tag, HcclComm comm, int* flag,
    HcclMessage* msg, HcclStatus* status);

extern int HcclGetCount(const HcclStatus* status, HcclDataType dataType, int* count);

extern int HcclTestSome(int count, HcclRequest requestArray[], int* compCount,
    int compIndices[], HcclStatus compStatus[]);

/**
 * @ingroup raw communication
 * @brief open HCCL connection handle
 * @param [out] conn    hanlde be created
 * @return HCCL_SUCCESS for ok
 * @return HCCL_E_PARA for error input
 */
extern HcclResult HcclRawOpen(HcclConn* conn);

/**
 * @ingroup raw communication
 * @brief close HCCL connection handle
 * @param [in] conn    hanlde that will be destroyed
 * @return HCCL_SUCCESS for ok
 * @return HCCL_E_PARA for error input
 */
extern HcclResult HcclRawClose(HcclConn conn);

/**
 * @ingroup raw communication
 * @brief force close HCCL connection handle, sockets will be immediately close
 * @param [in] conn    hanlde that will be destroyed
 * @return HCCL_SUCCESS for ok
 * @return HCCL_E_PARA for error input
 */
extern HcclResult HcclRawForceClose(HcclConn conn);

/**
 * @ingroup raw communication
 * @brief bind a communiocation address for the handle
 * @param [in] conn    connection hanlde
 * @param [in] bindAddr    hccl address to which the handle will be bind
 * @return HCCL_SUCCESS for connect suncess
 * @return HCCL_E_AGAIN for need retry
 * @return HCCL_E_PARA for error input
 */
extern HcclResult HcclRawBind(HcclConn conn, HcclAddr* bindAddr);

/**
 * @ingroup raw communication
 * @brief try to connect to remote as client role
 * @param [in] conn    hanlde that try to connect
 * @param [in] connectionAddr    remote hccl address
 * @return HCCL_SUCCESS for connect suncess
 * @return HCCL_E_AGAIN for need retry
 * @return HCCL_E_PARA for error input
 */
extern HcclResult HcclRawConnect(HcclConn conn, HcclAddr* connectAddr);

/**
 * @ingroup raw communication
 * @brief listen communiocation peer for the handle with a pre-bind HCCL address
 * @param [in] conn    connection hanlde
 * @param [in] bakLog    max peer can be queued in parallel when listening
 * @return HCCL_SUCCESS for listen OK
 * @return HCCL_E_PARA for error input
 */
extern HcclResult HcclRawListen(HcclConn conn, int backLog);

/**
 * @ingroup raw communication
 * @brief accept communiocation peer for the handle with a listend handle
 * @param [in] listenConn    connection hanlde
 * @param [out] acceptAddr   peer address that accepted
 * @param [out] acceptConn   handle for peer communication
 * @return HCCL_SUCCESS for listen OK
 * @return HCCL_E_AGAIN for need retry
 * @return HCCL_E_PARA for error input
 */
extern HcclResult HcclRawAccept(HcclConn listenConn, HcclAddr* acceptAddr, HcclConn* acceptConn);

/**
 * @ingroup raw communication
 * @brief raw non-blocking send
 * @param [in] conn    connection hanlde with which replace {comm, rank, tag} in MPI-like APIs
 * @param [in|out]  other params same as HcclIsend
 * @return same as HcclIsend
 */
extern HcclResult HcclRawIsend(const void* buf, int count, HcclDataType dataType, HcclConn conn, HcclRequest* request);

/**
 * @ingroup raw communication
 * @brief raw non-blocking message probe
 * @param [in] conn    connection hanlde with which replace {comm, rank, tag} in MPI-like APIs
 * @param [in|out]  other params same as HcclIsend
 * @return same as HcclImprobe
 */
extern HcclResult HcclRawImprobe(HcclConn conn, int* flag, HcclMessage* msg, HcclStatus* status);

/**
 * @ingroup raw communication
 * @brief raw non-blocking message recv
 * @param [in|out]  all params same as HcclIsend
 * @return same as HcclImrecv
 */
extern HcclResult HcclRawImrecv(void* buf, int count, HcclDataType datatype, HcclMessage* msg, HcclRequest* request);

extern HcclResult HcclRawImrecvScatter(void* buf[], int count[], int bufCount, HcclDataType datatype,
    HcclMessage* msg, HcclRequest* request);

/**
 * @ingroup raw communication
 * @brief raw non-blocking message recv
 * @param [in|out]  all params same as HcclIsend
 * @return same as HcclGetCount
 */
extern HcclResult HcclRawGetCount(const HcclStatus* status, HcclDataType dataType, int* count);

/**
 * @ingroup raw communication
 * @brief raw non-blocking message recv
 * @param [in|out]  all params same as HcclIsend
 * @return same as HcclTestSome
 */
extern HcclResult HcclRawTestSome(int count, HcclRequest requestArray[], int* compCount,
    int compIndices[], HcclStatus compStatus[]);


extern HcclResult HcclSetGrpIdCallback(int (*grpIdCallback)(int tag, int *grpId, int *devId));

// commContext
extern HcclResult HcclCreateComResource(const char* commName, u32 streamMode, void** commContext);

extern HcclResult HcclGetAicpuOpStreamNotify(const char* commName, rtStream_t* Opstream, void** aicpuNotify);

extern HcclResult HcclAllocComResource(HcclComm comm, u32 streamMode, void** commContext);

extern HcclResult HcclAllocComResourceByTiling(HcclComm comm, void* stream, void* Mc2Tiling, void** commContext);

extern HcclResult HcclGetAicpuOpStreamAndNotify(HcclComm comm, rtStream_t* opstream, u8 aicpuNotifyNum,
    void** aicpuNotify);

extern HcclResult HcclGetTopoDesc(HcclComm comm, HcclTopoDescs *topoDescs, uint32_t topoSize);

/**
* @brief Register memory for communicator
* @param comm A pointer identifying the communication resource
* @param addr The address of the window memory to register
* @param size The size in bytes of the window memory
* @param handle Pointer to store the handle identifying the registered memory
* @param flag Reserved parameters, default to 0
*/
extern HcclResult HcclCommRegister(HcclComm comm, void* addr, uint64_t size, void **handle, uint32_t flag);

/**
* @brief Unregister memory for communicator
* @param comm A pointer identifying the communication resource
* @param handle The handle of memory registered by @ref HcclCommRegister()
*/
extern HcclResult HcclCommDeregister(HcclComm comm, void* handle);

/**
* @brief Exchange user memory with peer ranks
* @param comm A pointer identifying the communication resource
* @param handle The handle of memory registered by @ref HcclCommRegister()
* @param peerRanks Array of destination ranks to exchange with
* @param peerRankNum Number of destination ranks in the peerRanks array
*/
extern HcclResult HcclCommExchangeMem(HcclComm comm, void* windowHandle, uint32_t* peerRanks, uint32_t peerRankNum);
#ifdef __cplusplus
}
#endif // __cplusplus
#endif // HCCL_EX_H
