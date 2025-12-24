/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "tensor_data_transfer.h"
#include <map>
#include <mutex>
#include <unordered_map>

#include "data_common.h"
#include "tdt_host_interface.h"

#include "log_inner.h"
#include "acl/acl_tdt_queue.h"
#include "queue.h"
#include "runtime/rt_mem_queue.h"
#include "runtime/mem.h"
#include "runtime/context.h"
#include "runtime/rts/rts_mem.h"
#include "utils/file_utils.h"

namespace {
    std::mutex aclChannleMutex;
    std::map<std::string, acltdtChannelHandle *> aclChannleMap;
    std::map<std::string, aclDataType> aclDataTypeStrMap =
    {
        {"bool",     ACL_BOOL},
        {"int8",     ACL_INT8},
        {"uint8",    ACL_UINT8},
        {"half",     ACL_FLOAT16},
        {"int16",    ACL_INT16},
        {"uint16",   ACL_UINT16},
        {"float",    ACL_FLOAT},
        {"int32",    ACL_INT32},
        {"uint32",   ACL_UINT32},
        {"int64",    ACL_INT64},
        {"uint64",   ACL_UINT64},
        {"double",   ACL_DOUBLE},
        {"string",   ACL_STRING}
    };
    constexpr uint32_t VERSION_NAME = 1U;
    constexpr size_t TDT_TENSOR_ALIGNE_UNIT = 64UL;
    const std::vector<size_t> GEAR_SIZE{1U * 1024U * 1024U, 10U * 1024U * 1024U, 100U * 1024U * 1024U,
        500U * 1024U * 1024U};
    size_t Get64AlignedSize(const size_t size)
    {
        return (size + TDT_TENSOR_ALIGNE_UNIT - 1UL) / TDT_TENSOR_ALIGNE_UNIT * TDT_TENSOR_ALIGNE_UNIT;
    }

    using TdtHostInitFunc = int32_t (*)(uint32_t);
    using TdtHostPreparePopDataFunc = int32_t (*)();
    using TdtHostPopDataFunc = int32_t (*)(const std::string &, std::vector<tdt::DataItem> &);
    using TdtHostPushDataFunc = int32_t (*)(const std::string &, const std::vector<tdt::DataItem> &, uint32_t deviceId);
    using TdtHostStopFunc = int32_t (*)(const std::string &);
    using TdtHostDestroyFunc = int32_t (*)();

#ifndef RUN_TEST
    void *GetHandler()
    {
        std::string soPath;
        if (acl::file_utils::GetSoRealPath(soPath) != ACL_SUCCESS) {
            ACL_LOG_ERROR("Get libacl_tdt_channel.so path failed.");
            return nullptr;
        }
        std::string soName = soPath + "libdatatransfer.so";
        // Load the "libdatatransfer.so" library until the program ends. During the process, Dlclose is not invoked
        // to prevent the destruction of the global state information saved in ibdatatransfer.so.
        void *handler = mmDlopen(soName.c_str(), RTLD_NOW | RTLD_GLOBAL);
        if (handler == nullptr) {
            ACL_LOG_ERROR("The corresponding dependent dynamic library cannot be found. "
                          "Please confirm whether the environment supports it and if the extension package has been correctly installed. "
                          "soName is %s.", soName.c_str());
        }
        return handler;
    }
#endif

    void *GetFunction(const std::string &func_name)
    {
#ifdef RUN_TEST
        std::unordered_map<std::string, void*> stubFunctionMap = {
            {"TdtHostInit", reinterpret_cast<void*>(&tdt::TdtHostInit)},
            {"TdtHostPushData", reinterpret_cast<void*>(&tdt::TdtHostPushData)},
            {"TdtHostDestroy", reinterpret_cast<void*>(&tdt::TdtHostDestroy)},
            {"TdtHostPreparePopData", reinterpret_cast<void*>(&tdt::TdtHostPreparePopData)},
            {"TdtHostPopData", reinterpret_cast<void*>(&tdt::TdtHostPopData)},
            {"TdtHostStop", reinterpret_cast<void*>(&tdt::TdtHostStop)}
        };
        auto it = stubFunctionMap.find(func_name);
        if (it != stubFunctionMap.end()) {
            return it->second;
        }
        return nullptr;
#else
        static void *handler = GetHandler();
        if (handler == nullptr) {
            ACL_LOG_ERROR("Get handler failed when get %s function.", func_name);
            return nullptr;
        }
        void *func_ptr = mmDlsym(handler, func_name.c_str());
        if (func_ptr == nullptr) {
            ACL_LOG_ERROR("The corresponding symbol cannot be found. Please confirm whether the installed extension package is correct, %s.", mmDlerror());
        }
        return func_ptr;
#endif
    }
}

namespace acl {
    bool GetTensorShape(const std::string &dimsStr, std::vector<int64_t> &dims)
    {
        // change "[32,224,224,3]" => "32,224,224,3"
        // tensor_shape.size() - 2 is the second to last
        if (dimsStr.size() < 2) {
            ACL_LOG_INNER_ERROR("[Check][dimsStr]Invalid shape string: %s", dimsStr.c_str());
            return false;
        }

        std::string str = dimsStr.substr(1, dimsStr.size() - 2);
        std::string::size_type index = 0;
        if (!str.empty()) {
            while ((index = str.find(' ', index)) != std::string::npos) {
                str.erase(index, 1);
            }
        }
        std::string split = ",";
        std::string::size_type pos2 = str.find(split);
        std::string::size_type pos1 = 0;
        while (pos2 != std::string::npos) {
            try {
                dims.push_back(std::stoll(str.substr(pos1, pos2 - pos1)));
            } catch (...) {
                ACL_LOG_INNER_ERROR("[Check][Shape]Invalid shape string: %s", dimsStr.c_str());
                return false;
            }
            // string::size_type can store the length of any string object
            pos1 = pos2 + split.size();
            pos2 = str.find(split, pos1);
        }
        if (pos1 != str.length()) {
            try {
                dims.push_back(std::stoll(str.substr(pos1)));
            } catch (...) {
                ACL_LOG_INNER_ERROR("[Check][Shape]Invalid shape string: %s", dimsStr.c_str());
                return false;
            }
        }
        return true;
    }

    aclError GetTdtDataTypeByAclDataType(acltdtTensorType aclType, tdt::TdtDataType &tdtDataType)
    {
        switch (aclType) {
            case ACL_TENSOR_DATA_END_OF_SEQUENCE: {
                tdtDataType = tdt::TDT_END_OF_SEQUENCE;
                break;
            }
            case ACL_TENSOR_DATA_TENSOR: {
                tdtDataType = tdt::TDT_TENSOR;
                break;
            }
            case ACL_TENSOR_DATA_ABNORMAL: {
                tdtDataType = tdt::TDT_ABNORMAL;
                break;
            }
            default: {
                ACL_LOG_INNER_ERROR("[Check][Type]unkown acltdtTensorType %d.", aclType);
                return ACL_ERROR_INVALID_PARAM;
            }
        }
        return ACL_SUCCESS;
    }

    aclError GetTdtDataTypeByAclDataTypeV2(acltdtTensorType aclType, int32_t &tdtDataType)
    {
        switch (aclType) {
            case ACL_TENSOR_DATA_END_OF_SEQUENCE: {
                tdtDataType = 1;
                break;
            }
            case ACL_TENSOR_DATA_TENSOR: {
                tdtDataType = 0;
                break;
            }
            case ACL_TENSOR_DATA_ABNORMAL: {
                tdtDataType = 2;
                break;
            }
            default: {
                ACL_LOG_INNER_ERROR("[Check][Type]unkown acltdtTensorType %d.", aclType);
                return ACL_ERROR_INVALID_PARAM;
            }
        }
        return ACL_SUCCESS;
    }

    aclError GetAclTypeByTdtDataType(tdt::TdtDataType tdtDataType, acltdtTensorType &aclType)
    {
        switch (tdtDataType) {
            case tdt::TDT_END_OF_SEQUENCE: {
                aclType = ACL_TENSOR_DATA_END_OF_SEQUENCE;
                break;
            }
            case tdt::TDT_TENSOR: {
                aclType = ACL_TENSOR_DATA_TENSOR;
                break;
            }
            case tdt::TDT_ABNORMAL: {
                aclType = ACL_TENSOR_DATA_ABNORMAL;
                break;
            }
            default: {
                ACL_LOG_INNER_ERROR("[Check][Datatype]unkown TdtDataType %d.", tdtDataType);
                return ACL_ERROR_UNSUPPORTED_DATA_TYPE;
            }
        }
        return ACL_SUCCESS;
    }

    aclError GetAclTypeByTdtDataTypeV2(int32_t tdtDataType, acltdtTensorType &aclType)
    {
        switch (tdtDataType) {
            case 1: {
                aclType = ACL_TENSOR_DATA_END_OF_SEQUENCE;
                break;
            }
            case 0: {
                aclType = ACL_TENSOR_DATA_TENSOR;
                break;
            }
            case 2: {
                aclType = ACL_TENSOR_DATA_ABNORMAL;
                break;
            }
            case 3: {
                aclType = ACL_TENSOR_DATA_SLICE_TENSOR;
                break;
            }
            case 4: {
                aclType = ACL_TENSOR_DATA_END_TENSOR;
                break;
            }
            default: {
                ACL_LOG_INNER_ERROR("[Check][Datatype]unkown TdtDataType %d.", tdtDataType);
                return ACL_ERROR_UNSUPPORTED_DATA_TYPE;
            }
        }
        return ACL_SUCCESS;
    }

    aclError TensorDatasetSerializes(const acltdtDataset *dataset, std::vector<tdt::DataItem> &itemVec)
    {
        ACL_REQUIRES_NOT_NULL(dataset);

        for (size_t i = 0; i < dataset->blobs.size(); ++i) {
            tdt::DataItem item;
            tdt::TdtDataType tdtDataType;
            auto ret = GetTdtDataTypeByAclDataType(dataset->blobs[i]->tdtType, tdtDataType);
            if (ret != ACL_SUCCESS) {
                ACL_LOG_INNER_ERROR("[Check][Dataset]TensorDatasetSerializes failed, "
                    "invalid tdt type %d", dataset->blobs[i]->tdtType);
                itemVec.clear();
                return ret;
            }

            item.dataType_ = tdtDataType;
            item.tensorShape_ = dataset->blobs[i]->dimsStr;
            item.tensorType_ = dataset->blobs[i]->dataTypeStr;
            item.dataLen_ = dataset->blobs[i]->dataLen;
            item.dataPtr_ = dataset->blobs[i]->dataPtr;
            itemVec.emplace_back(item);
        }
        return ACL_SUCCESS;
    }

    aclError TensorDatasetSerializesV2(const acltdtDataset *dataset, std::vector<acl::aclTdtDataItemInfo> &itemVec)
    {
        ACL_REQUIRES_NOT_NULL(dataset);
        for (size_t i = 0; i < dataset->blobs.size(); ++i) {
            acl::aclTdtDataItemInfo item;
            int32_t tdtDataType;
            auto ret = GetTdtDataTypeByAclDataTypeV2(dataset->blobs[i]->tdtType, tdtDataType);
            if (ret != ACL_SUCCESS) {
                ACL_LOG_INNER_ERROR("[Check][Dataset]TensorDatasetSerializes failed, "
                    "invalid tdt type %d", dataset->blobs[i]->tdtType);
                return ret;
            }

            item.ctrlInfo.dataType = tdtDataType;
            item.ctrlInfo.tensorType = dataset->blobs[i]->dataType;
            item.ctrlInfo.dimNum = dataset->blobs[i]->dims.size();
            item.dims = dataset->blobs[i]->dims;
            item.ctrlInfo.dataLen = dataset->blobs[i]->dataLen;
            item.dataPtr = dataset->blobs[i]->dataPtr;
            itemVec.emplace_back(item);
            ACL_LOG_DEBUG("TensorDatasetSerializesWithQueue, dataType %d, tensorType %d, dimNum %u, dataLen %lu",
                item.ctrlInfo.dataType, item.ctrlInfo.tensorType, item.ctrlInfo.dimNum, item.ctrlInfo.dataLen);
        }
        return ACL_SUCCESS;
    }

    aclError TensorDatasetDeserializes(const std::vector<tdt::DataItem> &itemVec, acltdtDataset *dataset)
    {
        ACL_REQUIRES_NOT_NULL(dataset);
        if (dataset->blobs.size() != 0) {
            ACL_LOG_INNER_ERROR("[Check][Dataset]Dataset size[%zu] is not empty", dataset->blobs.size());
            return ACL_ERROR_INVALID_PARAM;
        }
        aclError ret = ACL_SUCCESS;
        for (size_t i = 0; i < itemVec.size(); ++i) {
            acltdtTensorType aclType;
            ret = GetAclTypeByTdtDataType(itemVec[i].dataType_, aclType);
            if (ret != ACL_SUCCESS) {
                ACL_LOG_INNER_ERROR("[Check][Dataset]TensorDatasetDeserializes failed, invalid data type %d",
                    itemVec[i].dataType_);
                break;
            }

            if (aclType == ACL_TENSOR_DATA_TENSOR) {
                std::vector<int64_t> dims;
                if (!GetTensorShape(itemVec[i].tensorShape_, dims)) {
                    ACL_LOG_INNER_ERROR("[Check][TensorDataset]TensorDatasetDeserializes failed, "
                        "invalid tensor shape[%s]", itemVec[i].tensorShape_.c_str());
                    ret = ACL_ERROR_INTERNAL_ERROR;
                    break;
                }

                std::map<std::string, aclDataType>::const_iterator iter =
                    aclDataTypeStrMap.find(itemVec[i].tensorType_);
                if (iter == aclDataTypeStrMap.cend()) {
                    ACL_LOG_INNER_ERROR("[Deserialize][TensorDataset]TensorDatasetDeserializes failed, "
                        "unkown data type[%s]", itemVec[i].tensorType_.c_str());
                    ret = ACL_ERROR_INTERNAL_ERROR;
                    break;
                }
                aclDataType dataType = iter->second;
                acltdtDataItem *item = new(std::nothrow) acltdtDataItem(aclType,
                    &dims[0], dims.size(), itemVec[i].tensorShape_,
                    dataType, itemVec[i].tensorType_,
                    itemVec[i].dataPtr_, itemVec[i].dataLen_);
                if (item == nullptr) {
                    ACL_LOG_INNER_ERROR("[Check][Item]TensorDatasetDeserializes alloc failed");
                    ret = ACL_ERROR_BAD_ALLOC;
                    break;
                }
                dataset->blobs.push_back(item);
            } else {
                acltdtDataItem *item = new(std::nothrow) acltdtDataItem(aclType,
                    nullptr, 0, itemVec[i].tensorShape_, ACL_DT_UNDEFINED,
                    itemVec[i].tensorType_, itemVec[i].dataPtr_, itemVec[i].dataLen_);
                if (item == nullptr) {
                    ACL_LOG_INNER_ERROR("[Check][Item]TensorDatasetDeserializes alloc failed");
                    ret = ACL_ERROR_BAD_ALLOC;
                    break;
                }
                dataset->blobs.push_back(item);
            }
        }

        if (ret != ACL_SUCCESS) {
            for (size_t i = 0; i < dataset->blobs.size(); ++i) {
                ACL_DELETE_AND_SET_NULL(dataset->blobs[i]);
            }
            dataset->blobs.clear();
        }
        dataset->freeSelf = true;
        return ret;
    }

    aclError TensorDatasetDeserializesV2(const std::vector<acl::aclTdtDataItemInfo> &itemVec, acltdtDataset *dataset)
    {
        ACL_REQUIRES_NOT_NULL(dataset);
        if (!dataset->blobs.empty() && !dataset->freeSelf) {
            ACL_LOG_INNER_ERROR("[Check][Dataset]Dataset size[%zu] is not empty", dataset->blobs.size());
            return ACL_ERROR_INVALID_PARAM;
        }
        for (auto it = dataset->blobs.begin(); it != dataset->blobs.end(); ++it) {
            ACL_DELETE_AND_SET_NULL(*it);
        }
        dataset->blobs.clear();
        aclError ret = ACL_SUCCESS;
        for (size_t i = 0; i < itemVec.size(); ++i) {
            acltdtTensorType aclType;
            ret = GetAclTypeByTdtDataTypeV2(itemVec[i].ctrlInfo.dataType, aclType);
            if (ret != ACL_SUCCESS) {
                ACL_LOG_INNER_ERROR("[Check][Dataset]TensorDatasetDeserializes failed, invalid data type %d",
                    itemVec[i].ctrlInfo.dataType);
                break;
            }
            if ((aclType == ACL_TENSOR_DATA_TENSOR) || (aclType == ACL_TENSOR_DATA_SLICE_TENSOR)
                || (aclType == ACL_TENSOR_DATA_END_TENSOR)) {
                if (itemVec[i].ctrlInfo.version == VERSION_NAME) {
                    void *dataReal = (itemVec[i].priorityDataPtr_ != nullptr) ?
                        itemVec[i].priorityDataPtr_ : itemVec[i].dataPtr.get();
                    dataset->name.assign(static_cast<char *>(dataReal), itemVec[i].ctrlInfo.dataLen);
                    ACL_LOG_INFO("get dataset name is %s", dataset->name.c_str());
                    continue;
                }
                std::vector<int64_t> dims = itemVec[i].dims;
                aclDataType dataType = static_cast<aclDataType>(itemVec[i].ctrlInfo.tensorType);
                acltdtDataItem *item = new(std::nothrow) acltdtDataItem(aclType,
                    &dims[0], dims.size(), "",
                    dataType, "",
                    itemVec[i].dataPtr, itemVec[i].ctrlInfo.dataLen);
                if (item == nullptr) {
                    ACL_LOG_INNER_ERROR("[Check][Item]TensorDatasetDeserializes alloc failed");
                    ret = ACL_ERROR_BAD_ALLOC;
                    break;
                }
                item->sliceNum = itemVec[i].ctrlInfo.sliceNum;
                item->sliceId = itemVec[i].ctrlInfo.sliceId;
                item->priorityData_ = itemVec[i].priorityDataPtr_;
                dataset->blobs.push_back(item);
            } else {
                acltdtDataItem *item = new(std::nothrow) acltdtDataItem(aclType,
                    nullptr, 0, "", ACL_DT_UNDEFINED,
                    "", itemVec[i].dataPtr, itemVec[i].ctrlInfo.dataLen);
                if (item == nullptr) {
                    ACL_LOG_INNER_ERROR("[Check][Item]TensorDatasetDeserializes alloc failed");
                    ret = ACL_ERROR_BAD_ALLOC;
                    break;
                }
                item->priorityData_ = itemVec[i].priorityDataPtr_;
                dataset->blobs.push_back(item);
            }
        }

        if (ret != ACL_SUCCESS) {
            for (size_t i = 0; i < dataset->blobs.size(); ++i) {
                ACL_DELETE_AND_SET_NULL(dataset->blobs[i]);
            }
            dataset->blobs.clear();
        }
        dataset->freeSelf = true;
        return ret;
    }

    void GetTensorDimsString(const int64_t *dims, size_t dimNum, std::string &dimsStr)
    {
        for (size_t i = 0; i < dimNum; ++i) {
            dimsStr += std::to_string(dims[i]);
            if (i + 1 == dimNum) {
                break;
            }
            dimsStr.push_back(',');
        }
        dimsStr += "]";
    }

    aclError SaveCtrlSharedPtrToVec(const datasetMemType memType, rtMemQueueBuffInfo &qItem,
        const std::shared_ptr<uint8_t> &ctrlSharedPtr, std::vector<std::shared_ptr<uint8_t>> &ctrlSharedPtrVec)
    {
        void *ctrlPtr = ctrlSharedPtr.get();
        if (memType == MEM_DEVICE) {
            uint8_t *devPtr = nullptr;
            std::shared_ptr<uint8_t> ctrlSharedDevPtr;
            ctrlSharedDevPtr.reset(devPtr, [](void *p) {
                if (p != nullptr) {
                    (void)rtFree(p);
                }
            });
            ACL_REQUIRES_CALL_RTS_OK(
                rtMalloc(reinterpret_cast<void **>(&devPtr), qItem.len, RT_MEMORY_DEFAULT, acl::ACL_MODE_ID_U16),
                rtMalloc);
            ACL_REQUIRES_CALL_RTS_OK(
                rtMemcpy(devPtr, qItem.len, ctrlPtr, qItem.len, RT_MEMCPY_HOST_TO_DEVICE), rtMemcpy);
            qItem.addr = devPtr;
            ctrlSharedPtrVec.push_back(ctrlSharedDevPtr);
        } else {
            qItem.addr = ctrlPtr;
            ctrlSharedPtrVec.push_back(ctrlSharedPtr);
        }
        return ACL_SUCCESS;
    }

    aclError TensorDataitemSerialize(std::vector<acl::aclTdtDataItemInfo> &itemVec, const datasetMemType memType,
        std::vector<rtMemQueueBuffInfo> &qBufVec, std::vector<std::shared_ptr<uint8_t>> &ctrlSharedPtrVec)
    {
        uint32_t currentCnt = 0;
        size_t lastDataSize = 0U;
        for (size_t i = 0; i < itemVec.size(); ++i) {
            itemVec[i].ctrlInfo.curCnt = currentCnt;
            itemVec[i].ctrlInfo.cnt = itemVec.size();
            size_t ctrlSize = sizeof(ItemInfo) + itemVec[i].dims.size() * sizeof(int64_t);
            // 64n + lastDataSize + 64n - lastDataSize
            size_t alignedSize = Get64AlignedSize(ctrlSize + lastDataSize) - lastDataSize;
            itemVec[i].ctrlInfo.dynamicBitSize = alignedSize - sizeof(ItemInfo);
            std::shared_ptr<uint8_t> ctrlSharedPtr(
                new (std::nothrow) uint8_t[alignedSize], std::default_delete<uint8_t[]>());
            ACL_CHECK_MALLOC_RESULT(ctrlSharedPtr);
            void *ctrlPtr = ctrlSharedPtr.get();
            ACL_LOG_DEBUG("TensorDataitemSerialize alignedSize is %zu, ctrlSize is %zu, dynamicBitSize is %u, i is %zu,"
                " lastDataSize is %zu, shape size is %zu", alignedSize, ctrlSize, itemVec[i].ctrlInfo.dynamicBitSize,
                i, lastDataSize, itemVec[i].dims.size());
            auto ret = memcpy_s(ctrlPtr, alignedSize, &itemVec[i].ctrlInfo, sizeof(ItemInfo));
            if (ret != EN_OK) {
                ACL_LOG_INNER_ERROR("[Call][MemCpy]call memcpy failed, result=%d, srcLen=%zu, dstLen=%zu",
                    ret, sizeof(ItemInfo), alignedSize);
            }
            size_t offset = sizeof(ItemInfo);
            for (size_t j = 0; j < itemVec[i].dims.size(); ++j) {
                ret = memcpy_s(reinterpret_cast<uint8_t *>(ctrlPtr) + offset,
                    alignedSize - offset, &itemVec[i].dims[j], sizeof(int64_t));
                if (ret != EN_OK) {
                    ACL_LOG_INNER_ERROR("[Call][MemCpy]call memcpy failed, result=%d, srcLen=%zu, dstLen=%zu",
                                        ret, sizeof(int64_t), alignedSize - offset);
                }
                offset += sizeof(int64_t);
            }
            rtMemQueueBuffInfo qItem = {};
            qItem.len = alignedSize;
            ACL_REQUIRES_OK(SaveCtrlSharedPtrToVec(memType, qItem, ctrlSharedPtr, ctrlSharedPtrVec));
            qBufVec.push_back(qItem);

            if (itemVec[i].ctrlInfo.dataLen > 0U) {
                rtMemQueueBuffInfo tmpQItem = {itemVec[i].dataPtr.get(), itemVec[i].ctrlInfo.dataLen};
                qBufVec.push_back(tmpQItem);
            } else {
                ACL_LOG_DEBUG("no need to insert data buf");
            }
            // current total size is (64n + lastDataSize)
            lastDataSize = itemVec[i].ctrlInfo.dataLen;
            ++currentCnt;
        }
        return ACL_SUCCESS;
    }

    aclError UnpackageRecvDataInfo(uint8_t *outputHostAddr, size_t size, std::vector<acl::aclTdtDataItemInfo> &itemVec)
    {
        ItemInfo *head = reinterpret_cast<ItemInfo *>(outputHostAddr);
        uint32_t cnt = head->cnt;
        ACL_LOG_INFO("get tensor cnt is %u", cnt);
        size_t offset = 0;
        for (uint32_t i = 0; i < cnt; ++i) {
            if (offset + sizeof(ItemInfo) > size) {
                ACL_LOG_ERROR("offset is %zu, size is %zu", offset, size);
                return ACL_ERROR_FAILURE;
            }
            acl::aclTdtDataItemInfo item;
            ItemInfo *tmp = reinterpret_cast<ItemInfo *>(outputHostAddr + offset);
            item.ctrlInfo = *tmp;
            ACL_LOG_INFO("UnpackInfo version %d, dataType %d, curCnt %u, cnt %u, tensorType %d, dimNum %u, "
                "dynamicBitSize %u, sliceNum %u, sliceId %u, dataLen %lu", tmp->version, tmp->dataType, tmp->curCnt,
                tmp->cnt, tmp->tensorType, tmp->dimNum, tmp->dynamicBitSize, static_cast<uint32_t>(tmp->sliceNum),
                static_cast<uint32_t>(tmp->sliceId), tmp->dataLen);
            offset += sizeof(ItemInfo);

            for (uint32_t j = 0; j < tmp->dimNum; ++j) {
                if (offset + sizeof(int64_t) > size) {
                    ACL_LOG_ERROR("offset is %zu, size is %zu", offset, size);
                    return ACL_ERROR_FAILURE;
                }
                int64_t dimTmp = *(reinterpret_cast<int64_t *>(outputHostAddr + offset));
                item.dims.push_back(dimTmp);
                ACL_LOG_INFO("current dims[%u] is %ld", j, dimTmp);
                offset += sizeof(int64_t);
            }

            if (offset + tmp->dataLen > size) {
                ACL_LOG_ERROR("offset is %zu, data len is %lu, size is %zu", offset, tmp->dataLen, size);
                return ACL_ERROR_FAILURE;
            }
            if (tmp->dataLen > 0U) {
                item.priorityDataPtr_ = outputHostAddr + offset;
                offset += tmp->dataLen;
            } else {
                ACL_LOG_INFO("data length is 0");
            }
            ACL_LOG_INFO("after %u tensor, offset is %zu", i + 1, offset);
            itemVec.push_back(item);
        }
        return ACL_SUCCESS;
    }

    aclError acltdtSendTensorV2(const acltdtChannelHandle *handle, const acltdtDataset *dataset, int32_t timeout)
    {
        std::vector<acl::aclTdtDataItemInfo> itemVec;
        auto ret = acl::TensorDatasetSerializesV2(dataset, itemVec);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("[Serialize][Dataset]failed to TensorDatasetSerializesV2, device is %u, name is %s",
                handle->devId, handle->name.c_str());
            itemVec.clear();
            return ret;
        }
        std::vector<std::shared_ptr<uint8_t>> ctrlSharedPtrVec;
        std::vector<rtMemQueueBuffInfo> queueBufInfoVec;
        ret = acl::TensorDataitemSerialize(itemVec, dataset->memType, queueBufInfoVec, ctrlSharedPtrVec);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("[Serialize][Dataset]failed to TensorDataitemSerialize, device is %u, name is %s",
                handle->devId, handle->name.c_str());
            return ret;
        }

        rtMemQueueBuff_t queueBuf = {nullptr, 0U, nullptr, 0U};
        queueBuf.buffCount = queueBufInfoVec.size();
        queueBuf.buffInfo = queueBufInfoVec.data();
        ret = rtMemQueueEnQueueBuff(handle->devId, handle->qid, &queueBuf, timeout);
        if (ret == ACL_ERROR_RT_QUEUE_FULL) {
            ACL_LOG_DEBUG("queue is full, device is %u, name is %s", handle->devId, handle->name.c_str());
            return ret;
        }
        if (ret != RT_ERROR_NONE) {
            ACL_LOG_INNER_ERROR("Fail to execute acltdtSendTensor, device is %u, name is %s",
                handle->devId, handle->name.c_str());
            return ret;
        }
        ACL_LOG_DEBUG("success to execute acltdtSendTensor, device is %u, name is %s",
            handle->devId, handle->name.c_str());
        return ACL_SUCCESS;
    }

    aclError EnsureCurrentThreadHasContext(const acltdtChannelHandle *handle)
    {
        rtContext_t rtCtx = nullptr;
        const rtError_t rtRet = rtCtxGetCurrent(&rtCtx);
        if ((rtRet != ACL_RT_SUCCESS) && (rtRet != ACL_ERROR_RT_CONTEXT_NULL)) {
            ACL_LOG_CALL_ERROR("rtCtxGetCurrent faild");
            return rtRet;
        }
        if (rtCtx == nullptr) {
            if (handle->ctx_ == nullptr) {
                ACL_LOG_INFO("current thread need to create new context");
                ACL_REQUIRES_CALL_RTS_OK(rtCtxCreateEx(&rtCtx, static_cast<uint32_t>(RT_CTX_NORMAL_MODE),
                    handle->devId), rtCtxCreateEx);
                const_cast<acltdtChannelHandle *>(handle)->ctx_.reset(rtCtx,
                    [](void *p) {if (p != nullptr) {(void)rtCtxDestroyEx(p);}});
            }
            ACL_REQUIRES_CALL_RTS_OK(rtCtxSetCurrent(handle->ctx_.get()), rtCtxSetCurrent);
        }
        return ACL_SUCCESS;
    }

    size_t GetMallocSize(const size_t bufLen)
    {
        // 超出当前档位就是bufLen, 在档位内就是上限值，并保存当前申请的值
        for (const size_t& size : GEAR_SIZE) {
            if (bufLen <= size) {
                return size;
            }
        }
        return bufLen;
    }

    aclError GetOrMallocHostMem(const acltdtChannelHandle *handle, acltdtDataset *dataset,
        size_t bufLen, void *&hostPtr)
    {
        ACL_LOG_INFO("current need size is %zu, current mem size is %zu", bufLen, dataset->sharedMemSize_);
        ACL_REQUIRES_OK(EnsureCurrentThreadHasContext(handle));
        if (bufLen > dataset->sharedMemSize_) {
            const size_t mallocSize = GetMallocSize(bufLen);
            ACL_LOG_INFO("need mallochost size %zu, bufLen is %zu", mallocSize, bufLen);
            void *outHostAddr = nullptr;
            ACL_REQUIRES_CALL_RTS_OK(rtMallocHost(&outHostAddr, mallocSize, acl::ACL_MODE_ID_U16), rtMallocHost);
            ACL_CHECK_MALLOC_RESULT(outHostAddr);
            dataset->sharedMem_.reset(outHostAddr, [](void *p) {if (p != nullptr) {(void)rtFreeHost(p);}});
            dataset->sharedMemSize_ = mallocSize;
        }
        hostPtr = dataset->sharedMem_.get();
        return ACL_SUCCESS;
    }

    aclError acltdtReceiveTensorV2(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout)
    {
        size_t bufLen = 0;
        auto ret = rtMemQueuePeek(handle->devId, handle->qid, &bufLen, timeout);
        if (ret == ACL_ERROR_RT_QUEUE_EMPTY) {
            ACL_LOG_INFO("queue is empty, device is %u, name is %s", handle->devId, handle->name.c_str());
            return ret;
        }
        if (ret != RT_ERROR_NONE) {
            ACL_LOG_ERROR("peek queue [%u] failed", handle->qid);
            return ret;
        }
        ACL_LOG_INFO("peek queue [%u] success, bufLen is %zu", handle->qid, bufLen);
        if (bufLen == 0) {
            ACL_LOG_INNER_ERROR("[Check][bufLen]peek queue len can not be zero");
            return ACL_ERROR_FAILURE;
        }
        void *hostPtr = nullptr;
        ACL_REQUIRES_OK(GetOrMallocHostMem(handle, dataset, bufLen, hostPtr));

        rtMemQueueBuff_t queueBuf = {nullptr, 0U, nullptr, 0U};
        rtMemQueueBuffInfo queueBufInfo = {hostPtr, bufLen};
        queueBuf.buffCount = 1;
        queueBuf.buffInfo = &queueBufInfo;
        ret = rtMemQueueDeQueueBuff(handle->devId, handle->qid, &queueBuf, 0);
        if (ret == ACL_ERROR_RT_QUEUE_EMPTY) {
            ACL_LOG_INFO("queue is empty, device is %u, name is %s", handle->devId, handle->name.c_str());
            return ret;
        }
        if (ret != RT_ERROR_NONE) {
            ACL_LOG_ERROR("failed to rtMemQueueDeQueueBuf, device is %u, name is %s",
                handle->devId, handle->name.c_str());
            return ret;
        }

        std::vector<acl::aclTdtDataItemInfo> itemVec;
        ret = acl::UnpackageRecvDataInfo(static_cast<uint8_t *>(hostPtr), bufLen, itemVec);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_ERROR("failed to UnpackageRecvDataInfo, device is %u, name is %s",
                handle->devId, handle->name.c_str());
            return ret;
        }
        ret = acl::TensorDatasetDeserializesV2(itemVec, dataset);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("[Deserialize][Dataset]failed to TensorDatasetDeserializesV2, device is %u, name is %s",
                handle->devId, handle->name.c_str());
            return ret;
        }
        ACL_LOG_INFO("success to execute acltdtReceiveTensorV2, device is %u, name is %s",
            handle->devId, handle->name.c_str());
        return ACL_SUCCESS;
    }
} // namespace acl

acltdtTensorType acltdtGetTensorTypeFromItem(const acltdtDataItem *dataItem)
{
    if (dataItem == nullptr) {
        ACL_LOG_ERROR("[Check][Dataitem]param [dataItem] must not be null.");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_NULL_POINTER_MSG,
            std::vector<const char *>({"param"}),
            std::vector<const char *>({"dataItem"}));
        return ACL_TENSOR_DATA_UNDEFINED;
    }
    return dataItem->tdtType;
}

aclDataType acltdtGetDataTypeFromItem(const acltdtDataItem *dataItem)
{
    if (dataItem == nullptr) {
        ACL_LOG_ERROR("[Check][Dataitem]param [dataItem] must not be null.");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_NULL_POINTER_MSG,
            std::vector<const char *>({"param"}),
            std::vector<const char *>({"dataItem"}));
        return ACL_DT_UNDEFINED;
    }
    return dataItem->dataType;
}

void *acltdtGetDataAddrFromItem(const acltdtDataItem *dataItem)
{
    ACL_REQUIRES_NOT_NULL_RET_NULL(dataItem);
    if (dataItem->priorityData_ != nullptr) {
        return dataItem->priorityData_;
    }
    return dataItem->dataPtr.get();
}

size_t acltdtGetDataSizeFromItem(const acltdtDataItem *dataItem)
{
    if (dataItem == nullptr) {
        ACL_LOG_ERROR("[Check][Dataitem]param [dataItem] must not be null.");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_NULL_POINTER_MSG,
            std::vector<const char *>({"param"}),
            std::vector<const char *>({"dataItem"}));
        return 0;
    }
    return dataItem->dataLen;
}

size_t acltdtGetDimNumFromItem(const acltdtDataItem *dataItem)
{
    if (dataItem == nullptr) {
        ACL_LOG_ERROR("[Check][Dataitem]param [dataItem] must not be null.");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_NULL_POINTER_MSG,
            std::vector<const char *>({"param"}),
            std::vector<const char *>({"dataItem"}));
        return 0;
    }
    return dataItem->dims.size();
}

aclError acltdtGetSliceInfoFromItem(const acltdtDataItem *dataItem, size_t *sliceNum, size_t *sliceId)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dataItem);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(sliceNum);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(sliceId);
    *sliceNum = dataItem->sliceNum;
    *sliceId = dataItem->sliceId;
    return ACL_SUCCESS;
}

aclError acltdtGetDimsFromItem(const acltdtDataItem *dataItem, int64_t *dims, size_t dimNum)
{
    ACL_REQUIRES_NOT_NULL(dataItem);
    // check dims and dimNum
    if ((dims == nullptr && dimNum != 0) || (dims != nullptr && dimNum == 0)) {
        ACL_LOG_INNER_ERROR("[Check][Params]acltdtGetDimsFromItem failed, invalid dims and dimNum[%zu]", dimNum);
        return ACL_ERROR_INVALID_PARAM;
    }

    if (dimNum < dataItem->dims.size()) {
        ACL_LOG_INNER_ERROR("[Check][dimNum]output dimNum[%zu] cannot be less than dims number[%zu]",
            dimNum, dataItem->dims.size());
        return ACL_ERROR_INVALID_PARAM;
    }

    for (size_t i = 0; i < dataItem->dims.size(); ++i) {
        dims[i] = dataItem->dims[i];
    }

    return ACL_SUCCESS;
}

const char *acltdtGetDatasetName(const acltdtDataset *dataset)
{
    if (dataset == nullptr) {
        ACL_LOG_ERROR("[Check][dataset]param [dataset] must not be null.");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_NULL_POINTER_MSG,
            std::vector<const char *>({"param"}), std::vector<const char *>({"dataset"}));
        return nullptr;
    }
    return dataset->name.c_str();
}

acltdtDataItem *acltdtCreateDataItem(acltdtTensorType tdtType,
    const int64_t *dims, size_t dimNum, aclDataType dataType, void *data, size_t size)
{
    if ((dims == nullptr && dimNum != 0) || (dims != nullptr && dimNum == 0)) {
        ACL_LOG_INNER_ERROR("[Check][Params]acltdtCreateDataItem failed, invalid dims and dimNum[%zu]", dimNum);
        return nullptr;
    }
    constexpr size_t MAX_DIM_CNT = 128UL;
    if (dimNum > MAX_DIM_CNT) {
        ACL_LOG_INNER_ERROR("[Check][Dimnum]acltdtCreateDataItem failed, dimNum[%zu] can't be larger than "
            "MAX_DIM_CNT[%zu]", dimNum, MAX_DIM_CNT);
        return nullptr;
    }

    if (tdtType != ACL_TENSOR_DATA_TENSOR) {
        if (dims != nullptr) {
            ACL_LOG_INNER_ERROR("[Check][Dims]acltdtCreateDataItem failed, "
                "dims must be nullptr. tdtType is %d", tdtType);
            return nullptr;
        }
        return new(std::nothrow) acltdtDataItem(tdtType, dims, dimNum, "[]", ACL_DT_UNDEFINED, "", nullptr, 0);
    }

    // tdtType: ACL_TENSOR_DATA_TENSOR
    std::string dimsStr = "[";
    acl::GetTensorDimsString(dims, dimNum, dimsStr);

    std::string typeStr;
    for (const auto &item: aclDataTypeStrMap) {
        if (item.second == dataType) {
            typeStr = item.first;
            break;
        }
    }
    std::shared_ptr<void> dataPtr;
    dataPtr.reset(data, [](const void *) {});
    return new(std::nothrow) acltdtDataItem(tdtType, dims, dimNum, dimsStr, dataType, typeStr, dataPtr, size);
}

aclError acltdtDestroyDataItem(acltdtDataItem *dataItem)
{
    ACL_REQUIRES_NOT_NULL(dataItem);
    ACL_DELETE_AND_SET_NULL(dataItem);
    return ACL_SUCCESS;
}

acltdtDataset *acltdtCreateDataset()
{
    return new(std::nothrow) acltdtDataset();
}

aclError acltdtDestroyDataset(acltdtDataset *dataset)
{
    ACL_REQUIRES_NOT_NULL(dataset);
    ACL_DELETE_AND_SET_NULL(dataset);
    return ACL_SUCCESS;
}

aclError acltdtAddDataItem(acltdtDataset *dataset, acltdtDataItem *dataItem)
{
    ACL_REQUIRES_NOT_NULL(dataset);
    ACL_REQUIRES_NOT_NULL(dataItem);
    if (dataset->freeSelf) {
        ACL_LOG_INNER_ERROR("[Check][Freeself]item cannot be added, because internal item already exists");
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }
    datasetMemType currentMemType = MEM_UNKNOWN;
    if (dataItem->dataPtr != nullptr) {
        rtPtrAttributes_t attr = {};
        ACL_REQUIRES_CALL_RTS_OK(rtsPointerGetAttributes(dataItem->dataPtr.get(), &attr), rtsPointerGetAttributes);
        if ((attr.location.type == RT_MEMORY_LOC_HOST) || (attr.location.type == RT_MEMORY_LOC_UNREGISTERED)) {
            currentMemType = MEM_HOST;
        } else {
            currentMemType = MEM_DEVICE;
        }
    }
    if (dataset->memType == MEM_UNKNOWN) {
        // only MEM_UNKNOWN status can be refreshed
        dataset->memType = currentMemType;
    }

    if ((dataset->memType != MEM_UNKNOWN) && (currentMemType != MEM_UNKNOWN)) {
        if (dataset->memType != currentMemType) {
            ACL_LOG_ERROR("dataitem must be all host addr or all device addr in one dataset");
            return ACL_ERROR_INVALID_PARAM;
        }
    }
    dataset->blobs.push_back(dataItem);
    return ACL_SUCCESS;
}

acltdtDataItem *acltdtGetDataItem(const acltdtDataset *dataset, size_t index)
{
    if ((dataset == nullptr) || (index >= dataset->blobs.size())) {
        ACL_LOG_INNER_ERROR("[Check][Dataset]input param is invalid, index[%zu]", index);
        return nullptr;
    }

    return dataset->blobs[index];
}

size_t acltdtGetDatasetSize(const acltdtDataset *dataset)
{
    if (dataset == nullptr) {
        ACL_LOG_ERROR("[Check][Dataset]dataset is null.");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_NULL_POINTER_MSG,
            std::vector<const char *>({"param"}), std::vector<const char *>({"dataset"}));
        return 0;
    }
    return dataset->blobs.size();
}

acltdtChannelHandle *acltdtCreateChannel(uint32_t deviceId, const char *name)
{
    ACL_REQUIRES_NOT_NULL_RET_NULL(name);
    static TdtHostInitFunc tdtHostInit = (TdtHostInitFunc)GetFunction("TdtHostInit");
    if (tdtHostInit == nullptr) {
        return nullptr;
    }
    auto ret = tdtHostInit(deviceId);
    if (ret != 0) {
        ACL_LOG_INNER_ERROR("[Init][Tdt]tdt host init failed, tdt result = %d", ret);
        return nullptr;
    }
    acltdtChannelHandle *handle = new(std::nothrow) acltdtChannelHandle(deviceId, name);
    if (handle != nullptr) {
        if (!handle->recvName.empty()) {
            static TdtHostPreparePopDataFunc tdtHostPreparePopData = (TdtHostPreparePopDataFunc)GetFunction("TdtHostPreparePopData");
            if (tdtHostPreparePopData == nullptr) {
                return nullptr;
            }
            (void)tdtHostPreparePopData();
        }
        {
            std::unique_lock<std::mutex> lk(aclChannleMutex);
            aclChannleMap[name] = handle;
        }
    }
    return handle;
}

acltdtChannelHandle *acltdtCreateChannelWithCapacity(uint32_t deviceId, const char *name, size_t capacity)
{
    ACL_REQUIRES_NOT_NULL_RET_NULL(name);
    ACL_LOG_INFO("acltdtCreateChannelWithCapacity devId is %u, name is %s, capacity is %zu", deviceId, name, capacity);
    if (strlen(name) + 1 > RT_MQ_MAX_NAME_LEN) {
        ACL_LOG_ERROR("name [%s] length %zu can not be larger than %d", name, (strlen(name) + 1U), RT_MQ_MAX_NAME_LEN);
        return nullptr;
    }
    acltdtChannelHandle *handle = new(std::nothrow) acltdtChannelHandle(deviceId, name);
    if (handle == nullptr) {
        ACL_LOG_INNER_ERROR("acltdtChannelHandle is nullptr");
        return nullptr;
    }
    handle->isTdtProcess = false;
    acltdtQueueAttr attr{};
    auto ret = memcpy_s(attr.name, RT_MQ_MAX_NAME_LEN, name, strlen(name) + 1);
    if (ret != EN_OK) {
        ACL_LOG_INNER_ERROR("[Call][MemCpy]call memcpy failed, result=%d, srcLen=%zu, dstLen=%d",
            ret, strlen(name) + 1, RT_MQ_MAX_NAME_LEN);
        ACL_DELETE_AND_SET_NULL(handle);
        return nullptr;
    }
    attr.depth = static_cast<uint32_t>(capacity);
    attr.workMode = RT_MQ_MODE_DEFAULT;
    attr.flowCtrlFlag = false;
    attr.flowCtrlDropTime = 0;
    attr.overWriteFlag = false;
    // queue init should be invokeed when device is open
    auto rtError = rtMemQueueInit(deviceId);
    if (rtError == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
        ACL_LOG_INFO("queue init failed due to runtime does not support.");
        ACL_DELETE_AND_SET_NULL(handle);
        return nullptr;
    }
    if ((rtError != RT_ERROR_NONE) && (rtError != ACL_ERROR_RT_REPEATED_INIT)) {
        ACL_LOG_INNER_ERROR("queue init failed, rtError is %d", rtError);
        ACL_DELETE_AND_SET_NULL(handle);
        return nullptr;
    }
    if (rtMemQueueCreate(deviceId, &attr, &handle->qid) != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("queue create failed, deviceid is %u", deviceId);
        ACL_DELETE_AND_SET_NULL(handle);
        return nullptr;
    }
    ACL_LOG_INFO("acltdtCreateChannelWithCapacity devId is %u, name is %s, real name is %s, qid is %u",
                 deviceId, handle->name.c_str(), name, handle->qid);
    return handle;
}

aclError acltdtStopChannel(acltdtChannelHandle *handle)
{
    ACL_REQUIRES_NOT_NULL(handle);
    ACL_LOG_INFO("start to acltdtStopChannel, device is %u, name is %s",
        handle->devId, handle->name.c_str());
    if (!handle->isTdtProcess) {
        ACL_LOG_INFO("new process , stop channel is no use");
        return ACL_SUCCESS;
    }
    if (!handle->recvName.empty()) {
        static TdtHostStopFunc tdtHostStop = (TdtHostStopFunc)GetFunction("TdtHostStop");
        if (tdtHostStop == nullptr) {
            return ACL_ERROR_FAILURE;
        }
        auto ret = tdtHostStop(handle->recvName);
        if (ret != 0) {
            ACL_LOG_INNER_ERROR("[Init][Tdt]tdt host stop failed for channel %s, tdt result = %d",
                handle->name.c_str(), ret);
            return ACL_ERROR_FAILURE;
        }
    }
    ACL_LOG_INFO("acltdtStopChannel success, device is %u, name is %s",
        handle->devId, handle->name.c_str());
    return ACL_SUCCESS;
}


aclError acltdtDestroyChannel(acltdtChannelHandle *handle)
{
    ACL_REQUIRES_NOT_NULL(handle);
    ACL_LOG_INFO("start to acltdtDestroyChannel, device is %u, name is %s",
        handle->devId, handle->name.c_str());
    if (!handle->isTdtProcess) {
        ACL_REQUIRES_CALL_RTS_OK(rtMemQueueDestroy(handle->devId, handle->qid), rtMemQueueDestroy);
        ACL_LOG_INFO("acltdtDestroyChannel success, device is %u, name is %s",
            handle->devId, handle->name.c_str());
        ACL_DELETE_AND_SET_NULL(handle);
        return ACL_SUCCESS;
    }
    std::unique_lock<std::mutex> lk(aclChannleMutex);
    aclChannleMap.erase(handle->name);
    if (aclChannleMap.size() == 0) {
        static TdtHostDestroyFunc tdtHostDestroy = (TdtHostDestroyFunc)GetFunction("TdtHostDestroy");
        if (tdtHostDestroy == nullptr) {
            return ACL_ERROR_FAILURE;
        }
        auto ret = tdtHostDestroy();
        if (ret != 0) {
            ACL_LOG_INNER_ERROR("[Destroy][Tdt]TdtHostDestroy failed, tdt result = %d", ret);
        }
    }

    ACL_DELETE_AND_SET_NULL(handle);
    return ACL_SUCCESS;
}

aclError acltdtCleanChannel(acltdtChannelHandle *handle)
{
  ACL_REQUIRES_NOT_NULL(handle);
  ACL_LOG_INFO("start to acltdtCleanChannel, device is %u, name is %s",
               handle->devId, handle->name.c_str());
  if (!handle->isTdtProcess) {
    ACL_REQUIRES_CALL_RTS_OK(rtMemQueueReset(handle->devId, handle->qid), rtMemQueueReset);
    ACL_LOG_INFO("acltdtCleanChannel success, device is %u, name is %s",
                 handle->devId, handle->name.c_str());
    return ACL_SUCCESS;
  }
  return ACL_ERROR_FEATURE_UNSUPPORTED;
}

aclError acltdtSendTensor(const acltdtChannelHandle *handle, const acltdtDataset *dataset, int32_t timeout)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dataset);
    ACL_LOG_DEBUG("start to execute acltdtSendTensor, device is %u, name is %s",
        handle->devId, handle->name.c_str());
    if (!handle->isTdtProcess) {
        ACL_LOG_DEBUG("new process, use queue process");
        return acl::acltdtSendTensorV2(handle, dataset, timeout);
    }
    // -1 represents infinite wait, it is must be -1 now
    if (timeout != -1) {
        ACL_LOG_ERROR("[Check][Timeout]only infinite wait is supported, "
            "it can only be set to -1, timeout[%d].", timeout);
        std::string errMsg = acl::AclErrorLogManager::FormatStr("it can only be set to -1, timeout[%d].", timeout);
        acl::AclErrorLogManager::ReportInputError(acl::UNSUPPORTED_FEATURE_MSG,
            std::vector<const char *>({"feature", "reason"}), std::vector<const char *>({"timeout", errMsg.c_str()}));
        return ACL_ERROR_INVALID_PARAM;
    }

    std::vector<tdt::DataItem> itemVec;
    auto ret = acl::TensorDatasetSerializes(dataset, itemVec);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("[Serialize][Dataset]failed to TensorDatasetSerializes, device is %u, name is %s",
            handle->devId, handle->name.c_str());
        itemVec.clear();
        return ret;
    }

    static TdtHostPushDataFunc tdtHostPushData = (TdtHostPushDataFunc)GetFunction("TdtHostPushData");
    if (tdtHostPushData == nullptr) {
        return ACL_ERROR_FAILURE;
    }
    int32_t sendRet = tdtHostPushData(handle->name, itemVec, 0);
    if (sendRet != 0) {
        ACL_LOG_INNER_ERROR("[Push][Data]failed to send, tdt result = %d, device is %u, name is %s",
            sendRet, handle->devId, handle->name.c_str());
        return ACL_ERROR_FAILURE;
    }

    ACL_LOG_DEBUG("success to execute acltdtSendTensor, device is %u, name is %s",
        handle->devId, handle->name.c_str());
    return ACL_SUCCESS;
}

aclError acltdtReceiveTensor(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dataset);
    ACL_LOG_INFO("start to execute acltdtReceiveTensor, device is %u, name is %s",
        handle->devId, handle->name.c_str());
    if (!handle->isTdtProcess) {
        ACL_LOG_INFO("new process, use queue process");
        return acl::acltdtReceiveTensorV2(handle, dataset, timeout);
    }
    // -1 represents infinite wait, it is must be -1 now
    if (timeout != -1) {
        ACL_LOG_ERROR("[Check][Timeout]only infinite wait is supported, "
            "it can only be set to -1, timeout[%d]", timeout);
        std::string errMsg = acl::AclErrorLogManager::FormatStr("it can only be set to -1, timeout[%d].", timeout);
        acl::AclErrorLogManager::ReportInputError(acl::UNSUPPORTED_FEATURE_MSG,
            std::vector<const char *>({"feature", "reason"}), std::vector<const char *>({"timeout", errMsg.c_str()}));
        return ACL_ERROR_INVALID_PARAM;
    }

    if (handle->recvName.empty()) {
        ACL_LOG_ERROR("[Check][Recvname]it is not a receive channel, failed to receive, device is %u, name is %s",
            handle->devId, handle->name.c_str());
        std::string errMsg = acl::AclErrorLogManager::FormatStr("failed to receive, device is %u, name is %s",
            handle->devId, handle->name.c_str());
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"receive channel", "", errMsg.c_str()}));
        return ACL_ERROR_INVALID_PARAM;
    }

    std::vector<tdt::DataItem> itemVec;
    static TdtHostPopDataFunc tdtHostPopData = (TdtHostPopDataFunc)GetFunction("TdtHostPopData");
    if (tdtHostPopData == nullptr) {
        return ACL_ERROR_FAILURE;
    }
    int32_t recvRet = tdtHostPopData(handle->recvName, itemVec);
    if (recvRet != 0) {
        ACL_LOG_INNER_ERROR("[Pop][Data]failed to receive, tdt result = %d, device is %u, name is %s",
            recvRet, handle->devId, handle->name.c_str());
        return ACL_ERROR_FAILURE;
    }

    auto ret = acl::TensorDatasetDeserializes(itemVec, dataset);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("[Deserialize][Dataset]failed to TensorDatasetDeserializes, device is %u, name is %s",
            handle->devId, handle->name.c_str());
        return ret;
    }

    ACL_LOG_INFO("success to execute acltdtReceiveTensor, device is %u, name is %s",
        handle->devId, handle->name.c_str());
    return ACL_SUCCESS;
}

aclError acltdtQueryChannelSize(const acltdtChannelHandle *handle, size_t *size)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(size);
    if (handle->isTdtProcess) {
        ACL_LOG_DEBUG("acltdtQueryChannelSize is not supported");
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }
    ACL_LOG_DEBUG("start to execute acltdtQueryChannelSize, device is %u, qid is %u", handle->devId, handle->qid);
    rtMemQueueInfo_t info;
    rtError_t ret = rtMemQueueQueryInfo(handle->devId, handle->qid, &info);
    if (ret != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("[Call][Rts]call rtMemQueueQueryInfo failed, device is %u, qid is %u",
                           handle->devId, handle->qid);
        return ret;
    }
    *size = static_cast<size_t>(info.size);
    ACL_LOG_DEBUG("success to execute acltdtQueryChannelSize, size is %zu, device is %u, qid is %u",
        *size, handle->devId, handle->qid);
    return ACL_SUCCESS;
}
