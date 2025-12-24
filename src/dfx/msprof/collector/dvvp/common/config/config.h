/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_COMMON_CONFIG_CONFIG_H
#define ANALYSIS_DVVP_COMMON_CONFIG_CONFIG_H

#include <cstdint>
#include <string>
#include <map>

namespace analysis {
namespace dvvp {
namespace common {
namespace config {
// /////////////////////common//////////////////////////////////
const std::string DEVICE_APP_DIR = "/usr/local/profiler/";
const std::string PROF_SCRIPT_FILE_PATH = "/usr/bin/msprof_data_collection.sh";
const std::string PROF_SCRIPT_PROF = "/var/prof_collect.sh";
const std::string SAMPLE_JSON = "sample.json";

const std::string ASCEND_HOSTPID = "ASCEND_HOSTPID";
const std::string ASCEND_WORK_PATH_ENV = "ASCEND_WORK_PATH";
const std::string PROFILING_RESULT_PATH = "profiling_data";

const std::string CONTAINER_NO_SUPPORT_MESSAGE = "MESSAGE_CONTAINER_NO_SUPPORT";

const char * const DEVICE_TAG_KEY = "Device";
const char * const CLOCK_MONOTONIC_RAW_KEY = "clock_monotonic_raw";
const char * const CLOCK_CNTVCT_KEY = "cntvct";
const char * const CLOCK_CNTVCT_KEY_DIFF = "cntvct_diff";

constexpr int32_t US_CONVERT_MS = 1000;
constexpr int32_t HZ_CONVERT_MS = 1000;
constexpr int32_t HZ_CONVERT_US = 1000000;
constexpr int32_t HZ_HUNDRED = 100;
constexpr int32_t HZ_TEN_THOUSAND = 10000;

constexpr int32_t MAX_PATH_LENGTH = 1024;

constexpr int32_t PROFILING_PACKET_MAX_LEN = (3 * 1024 * 1024);  // 3 * 1024 *1024 means 3mb

constexpr int32_t MSVP_BATCH_MAX_LEN = 2621440;  // 2621440 : 2.5 * 1024 *1024 means 2.5MB

constexpr int32_t RECEIVE_CHUNK_SIZE = 320; // chunk size:1024

constexpr int32_t HASH_DATA_MAX_LEN = 1024; // hash data max len:1024

constexpr int32_t MSVP_COLLECT_CLIENT_INPUT_MAX_LEN = 128;  // 128 is max string size

constexpr int32_t MSVP_PROFILER_THREADNAME_MAXNUM = 16;

constexpr int32_t MSVP_DECODE_MESSAGE_MAX_LEN = (128 * 1024 * 1024);  // 128 * 1024 *1024 means 128mb

constexpr int32_t MSVP_MESSAGE_TYPE_NAME_MAX_LEN = 1024;  // 1024 means 1KB

constexpr int32_t MSVP_CFG_MAX_SIZE = 64 * 1024 * 1024;  // 64 * 1024 *1024 means 64mb

constexpr long long MSVP_LARGE_FILE_MAX_LEN = 512 * 1024 * 1024; // 512 * 1024 * 1024 means 512mb
constexpr long long MSVP_SMALL_FILE_MAX_LEN = 2 * 1024 * 1024; // 2 * 1024 * 1024 means 2mb
constexpr uint32_t HOST_DATA_BUF_SIZE_M = 2097153; // 2097152 + 1 means 2m + '\0'

constexpr int32_t MSVP_CLN_SENDER_QUEUE_CAPCITY = 1024;
constexpr int32_t MSVP_CLN_SENDER_POOL_THREAD_NUM = 2;

constexpr uint64_t STORAGE_LIMIT_DOWN_THD = 200; // 200MB

constexpr int32_t MAX_PMU_EVENT = 1294;      // max ai core event is 0x50E
constexpr int32_t LITE_MAX_PMU_EVENT = 1813; // max ai core event is 0x715 for chip:12
constexpr int32_t ACC_MAX_PMU_EVENT = 1815;  // max ai core event is 0x717 for chip:15

constexpr int32_t MAX_PARAMS_LEN = 70;
constexpr int32_t MAX_APP_LEN = 2048;
constexpr int32_t HEX_MODE = 16;
constexpr int32_t DEC_MODE = 10;
constexpr int32_t MAX_PID_LENGTH = 8;
const std::string CUSTOM_METRICS = "Custom:";
const std::string NULL_CHUNK = "null";

constexpr uint32_t MS_TO_NS = 1000000; // 1ms = 1000000ns

#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
constexpr int32_t MSVP_PROCESS = NULL;
#else
constexpr int32_t MSVP_PROCESS = -1;
#endif

const char * const MSVP_UNDERLINE = "_";

constexpr int32_t HOST_PID_DEFAULT = -1;

const char * const MSVP_CHANNEL_POOL_NAME_PREFIX = "MSVP_ChanPool_";
const char * const MSVP_SENDER_POOL_NAME_PREFIX = "MSVP_SndPool_";

const char * const MSVP_CHANNEL_THREAD_NAME = "MSVP_ChanPoll";
const char * const MSVP_CHANNEL_BUFFER = "MSVP_ChanBuffer";
const char * const MSVP_CTRL_RECEIVER_THREAD_NAME = "MSVP_CtrlRecv";
const char * const MSVP_UPLOADER_THREAD_NAME = "MSVP_Upld";
const char * const MSVP_DEVICE_TRANSPORT_THREAD_NAME = "MSVP_DevTrans";
const char * const MSVP_PROF_TASK_THREAD_NAME = "MSVP_ProfTask";
const char * const MSVP_DEVICE_THREAD_NAME_PREFIX = "MSVP_Dev_";
const char * const MSVP_COLLECT_PERF_SCRIPT_THREAD_NAME = "MSVP_PerfScript";
const char * const MSVP_COLLECT_PROF_TIMER_THREAD_NAME = "MSVP_ProfTimer";
const char * const MSVP_UPLOADER_DUMPER_THREAD_NAME = "MSVP_UploaderDumper";
const char * const MSVP_HDC_DUMPER_THREAD_NAME = "MSVP_HdcDumper";
const char * const MSVP_RPC_DUMPER_THREAD_NAME = "MSVP_RpcDumper";
const char * const MSVP_HELPER_DUMPER_THREAD_NAME = "MSVP_HelperDumper";
const char * const MSVP_DYN_PROF_SERVER_THREAD_NAME = "MSVP_DynProfServer";
const char * const MSVP_DYN_PROF_CLIENT_THREAD_NAME = "MSVP_DynProfClient";
const char * const MSVP_TYPE_INFO_UPLOAD_THREAD_NAME = "MSVP_TypeInfoUpload";
const char * const MSVP_MSTX_DATA_HANDLE_THREAD_NAME = "MSVP_MstxDataHandle";
const char * const MSVP_DIAGNOSTIC_THREAD_NAME = "MSVP_Diagnostic";

// cloud prof config
constexpr int32_t MAX_DEVICE_NUMS = 8;

constexpr size_t THREAD_QUEUE_SIZE_DEFAULT = 64;

// prof peripheral job config
constexpr uint32_t DEFAULT_INTERVAL            = 100;
constexpr uint32_t DEAFULT_MASTER_ID           = 0xFFFFFFFF;
constexpr uint32_t PERIPHERAL_EVENT_READ       = 0;
constexpr uint32_t PERIPHERAL_EVENT_WRITE      = 1;
constexpr uint32_t PERIPHERAL_EVENT_APP_MEM    = 0;
constexpr uint32_t PERIPHERAL_EVENT_DEV_MEM    = 1;
constexpr int32_t PERIPHERAL_INTERVAL_MS_SMIN  = 10;
constexpr int32_t PERIPHERAL_INTERVAL_MS_MIN   = 1;
constexpr int32_t PERIPHERAL_INTERVAL_MS_MAX   = 1000;

// prof job config
const char * const PROF_SYS_CPU_USAGE_FILE = "SystemCpuUsage.data";
const char * const PROF_SYS_MEM_FILE = "Memory.data";
const char * const PROF_HOST_PROC_CPU_USAGE_FILE = "host_cpu.data";
const char * const PROF_HOST_PROC_MEM_USAGE_FILE = "host_mem.data";
const char * const PROF_HOST_SYS_NETWORK_USAGE_FILE = "host_network.data";
const char * const MSVP_PROF_DATA_DIR = "/data";
const char * const MSVP_PROF_PERF_DATA_FILE = "ai_ctrl_cpu.data.";
const char * const MSVP_PROF_PERF_RET_FILE_SUFFIX = ".txt";
const std::string PROF_AICORE_SAMPLE = "aicore sample based";
const std::string PROF_AIV_SAMPLE = "ai vector core sample based";
const std::string PROF_AICORE_TASK = "aicore task based";
const std::string PROF_AIV_TASK = "ai vector core task based";
const std::string PROF_HOST_JOBID = "64";

// prof task config
constexpr unsigned long PROCESS_WAIT_TIME = 500000;  // should not modify
const std::string PROF_TASK_STREAMTASK_QUEUE_NAME = "ProfTaskStreamBuffer";

// uploader config
const std::string UPLOADER_QUEUE_NAME = "UploaderQueue";
constexpr size_t UPLOADER_QUEUE_CAPACITY = 512;

// prof channel config
const std::string SPEED_PERFCOUNT_MODULE_NAME = std::string("ChannelReaderSpeed");
const std::string SPEEDALL_PERFCOUNT_MODULE_NAME = std::string("ChannelReaderSpeedAll");
constexpr size_t CHANNELPOLL_THREAD_QUEUE_SIZE = 8192;

// prof mgr config
const std::string PROF_FEATURE_TASK      = "task_trace";
constexpr int32_t PROF_MGR_TRACE_ID_DEFAULT_LEN  = 27;

// receive data config
constexpr size_t MAX_LOOP_TIMES = 1400; // the max send package nums of once Dump()
constexpr int32_t SLEEP_INTEVAL_US = 1000; // the interval of Run()
constexpr size_t RING_BUFF_CAPACITY = 32768; // 32768:32K. Note:capacity value must be 2^n
constexpr size_t COMPACT_RING_BUFF_CAPACITY = 65536; // 65536:64K. Note:capacity value must be 2^n
constexpr size_t ADDITIONAL_RING_BUFF_CAPACITY = 131072; // 131072:128K. Note:capacity value must be 2^n
constexpr size_t ADPROF_BUFF_CAPACITY = 16384; // 16384:16K. Note:capacity value must be 2^n
constexpr size_t GE_RING_BUFF_CAPACITY = 262144; // 262144:256K. Note:capacity value must be 2^n
constexpr size_t PROFTX_RING_BUFF_CAPACITY = 262144; // 262144:256K. Note:capacity value must be 2^n
constexpr size_t VARIABLE_ADDITIONAL_BUFF_CAPACITY = 65536; // 65536:64K. Note:capacity value must be 2^n

// sender config
constexpr int32_t SEND_BUFFER_LEN = 64 * 1024; // 64 * 1024 menas 64k
constexpr size_t SENDERPOOL_THREAD_QUEUE_SIZE = 8192;

// transport config config
const std::string HDC_PERFCOUNT_MODULE_NAME = std::string("HdcTransport");
const std::string FILE_PERFCOUNT_MODULE_NAME = std::string("FileTransport");
constexpr uint64_t TRANSPORT_PRI_FREQ = 128;

const char * const MSVP_PROF_ON = "on";
const char * const MSVP_PROF_OFF = "off";
const char * const MSVP_PROF_L0 = "l0";
const char * const MSVP_PROF_L1 = "l1";
const char * const MSVP_PROF_L2 = "l2";
const char * const MSVP_PROF_L3 = "l3";
const char * const MSVP_LEVEL_L0 = "level0";
const char * const MSVP_LEVEL_L1 = "level1";
const char * const MSVP_LEVEL_L2 = "level2";
const char * const MSVP_LEVEL_L3 = "level3";
const char * const MSVP_PROF_EMPTY_STRING = "";
const char * const MSVP_PROF_ACLAPI_MODE = "aclapi";
const char * const MSVP_PROF_SUBSCRIBE_MODE = "subscribe";
const char * const MSVP_PROF_SYSTEM_MODE = "system";
const char * const HELPER_HOST_CPU_MODE = "64";

// dynamic profiling
const std::string PROFILING_MODE_ENV = "PROFILING_MODE";
const std::string DYNAMIC_PROFILING_KEY_PID_ENV = "DYNAMIC_PROFILING_KEY_PID";
const std::string DYNAMIC_PROFILING_VALUE = "dynamic";
const std::string DELAY_DURARION_PROFILING_VALUE = "delay_or_duration";

// ai core metrics type
constexpr char ARITHMETIC_UTILIZATION[] = "ArithmeticUtilization";
constexpr char PIPE_UTILIZATION[] = "PipeUtilization";
constexpr char PIPE_UTILIZATION_EXCT[] = "PipeUtilizationExct";
constexpr char PIPE_EXECUTION_UTILIZATION[] = "PipelineExecuteUtilization";
constexpr char MEMORY_BANDWIDTH[] = "Memory";
constexpr char L0B_AND_WIDTH[] = "MemoryL0";
constexpr char RESOURCE_CONFLICT_RATIO[] = "ResourceConflictRatio";
constexpr char PROFILER_SAMPLE_CONFIG_ENV[] = "PROFILER_SAMPLECONFIG";
constexpr char MEMORY_UB[] = "MemoryUB";
constexpr char L2_CACHE[] = "L2Cache";
constexpr char MEMORY_ACCESS[] = "MemoryAccess";
constexpr char PIPESTALLCYCLE[] = "PipeStallCycle";
constexpr char SCALAR_RATIO[] = "ScalarRatio";
constexpr char RANK_ID_ENV[] = "RANK_ID";

// llc  profiling events type
constexpr char LLC_PROFILING_CAPACITY[] = "capacity";
constexpr char LLC_PROFILING_BANDWIDTH[] = "bandwidth";
constexpr char LLC_PROFILING_READ[] = "read";
constexpr char LLC_PROFILING_WRITE[] = "write";

// host sys events type
constexpr char HOST_SYS_CPU[] = "cpu";
constexpr char HOST_SYS_MEM[] = "mem";
constexpr char HOST_SYS_DISK[] = "disk";
constexpr char HOST_SYS_NETWORK[] = "network";
constexpr char HOST_SYS_OSRT[] = "osrt"; // os_runtime: system call && pthread

constexpr char OUTPUT_RECORD[] = "profiling_output_record";

// keypoint op's name/type
const char * const KEYPOINT_OP_NAME = "keypoint_op";
const char * const KEYPOINT_OP_TYPE = "na";

// hash data file tag
const std::string HASH_TAG = "hash_dic";
const char * const HASH_DIC_DELIMITER = ":";

// need paired ageing file
const char * const HWTS_DATA = "hwts.data";
const char * const AICORE_DATA = "aicore.data";
const char * const STORAGE_LIMIT_UNIT = "MB";

// analysis script param
constexpr char DEFAULT_INTERATION_ID[] = "-1";
constexpr char DEFAULT_MODEL_ID[]      = "-1";
const char * const PROFILING_SUMMARY_FORMAT = "csv";
const char * const PROFILING_EXPORT_TYPE_TEXT = "text";

// used for init param
constexpr int32_t DEFAULT_PROFILING_INTERVAL_5MS    = 5;
constexpr int32_t DEFAULT_PROFILING_INTERVAL_10MS   = 10;
constexpr int32_t DEFAULT_PROFILING_INTERVAL_20MS   = 20;
constexpr int32_t DEFAULT_PROFILING_INTERVAL_50MS   = 50;
constexpr int32_t DEFAULT_PROFILING_INTERVAL_100MS  = 100;
constexpr int32_t DEFAULT_PROFILING_INTERVAL_1000MS = 1000;    // 1000 cycle
constexpr int32_t DEFAULT_PROFILING_INTERVAL_100US   = 100;
constexpr int32_t DEFAULT_PROFILING_INTERVAL_10000US   = 10000;
constexpr int32_t DEFAULT_PROFILING_INTERVAL_20000US   = 20000;

enum FileChunkDataModule {
    PROFILING_DEFAULT_DATA_MODULE = 0,
    PROFILING_IS_FROM_MSPROF,
    PROFILING_IS_CTRL_DATA,
    PROFILING_IS_FROM_DEVICE,
    PROFILING_IS_FROM_MSPROF_DEVICE,
    PROFILING_IS_FROM_MSPROF_HOST,
    PROFILING_IS_FROM_INNER
};

enum MsprofReporterId {
    API_EVENT           = 0,
    COMPACT             = 1,
    ADDITIONAL          = 2,
    ADPROF              = 3,
    VARIABLE_ADDINFO    = 4
};

// instr profiling perf
constexpr int32_t DAVID_DIE0_AICORE_NUM             = 18;     // die 18
constexpr int32_t BIU_PERF_LOWER_GROUP_NUM          = 3;      // biu profiling group id 0 ~ 2
constexpr int32_t BIU_PERF_HIGHER_GROUP_NUM         = 6;      // biu profiling group id 0 ~ 5
constexpr int32_t DEFAULT_BIU_PERF_CYCLE            = 16;
constexpr int32_t INSTR_PROFILING_GROUP_MAX_NUM     = 25;     // instr profiling group id 0 ~ 24
constexpr int32_t INSTR_PROFILING_GROUP_CHANNEL_NUM = 3;      // instr profiling group contains 3 channel
constexpr int32_t INSTR_PROFILING_SAMPLE_FREQ_MIN   = 300;    // instr profiling sampling frequency min value
constexpr int32_t INSTR_PROFILING_SAMPLE_FREQ_MAX   = 30000;  // instr profiling sampling frequency max value

// number switch limit
constexpr uint32_t PROF_MAX_DYNAMIC_PID  = 2147483647;
constexpr uint32_t PROF_MAX_DYNAMIC_TIME = UINT32_MAX;

constexpr uint32_t TLV_VALUE_MAX_LEN = 1200;
constexpr uint32_t TLV_VALUE_CHUNK_MAX_LEN = 1032;
constexpr uint32_t TLV_VALUE_FILENAME_MAX_LEN = 64;
constexpr uint32_t TLV_VALUE_EXTRAINFO_MAX_LEN = 64;
constexpr uint32_t TLV_VALUE_ID_MAX_LEN = 16;
constexpr uint32_t TLV_HEAD = 0x5A5A5A5AU;

struct ProfTlv {
    uint32_t head;
    uint32_t version;
    uint32_t type;
    uint32_t len;
    uint8_t value[TLV_VALUE_MAX_LEN];
};

struct ProfTlvValue {
    bool isLastChunk;
    int32_t chunkModule;
    size_t chunkSize;
    int64_t offset;
    char chunk[TLV_VALUE_CHUNK_MAX_LEN];
    char fileName[TLV_VALUE_FILENAME_MAX_LEN];
    char extraInfo[TLV_VALUE_EXTRAINFO_MAX_LEN];
    char id[TLV_VALUE_ID_MAX_LEN];
};

}  // namespace config
}  // namespace common
}  // namespace dvvp
}  // namespace analysis

#endif
