/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "tsch/host_interface.h"
#include "tsch/tsch_interrupt.h"
#include "model/model_api.h"
#include "securec.h"

#define DRV_UT_HBM_BASE   (0x2000000)
#define DRV_UT_HBM_MAX_ADDR   (0x400000000)
#define DRV_UT_MAX_ALLOC  (DRV_UT_HBM_MAX_ADDR-DRV_UT_HBM_BASE)

uint8_t g_ts_task_cmd_queue_status=0x01;
uint8_t stubStr[1000];
ts_task_cmd_queue_t tsTaskCmd[8];
ts_task_report_queue_t tsReport;
extern modelRWStatus_t busDirectRead(void * ptr, uint64_t size, uint64_t address, uint32_t chip_index)
{
	if(!ptr)
		return MODEL_RW_ERROR_ADDRESS;
	if(address>DRV_UT_HBM_MAX_ADDR)
		return MODEL_RW_ERROR_ADDRESS;
	if(size>(DRV_UT_MAX_ALLOC-address))
		return MODEL_RW_ERROR_LEN;

	return MODEL_RW_ERROR_NONE;
}

extern modelRWStatus_t busDirectWrite(uint64_t address, uint64_t size, void * ptr, uint32_t chip_index)
{
	if(!ptr)
		return MODEL_RW_ERROR_ADDRESS;
	if(address>DRV_UT_HBM_MAX_ADDR)
		return MODEL_RW_ERROR_ADDRESS;
	if(size>(DRV_UT_MAX_ALLOC-address))
		return MODEL_RW_ERROR_LEN;

	return MODEL_RW_ERROR_NONE;
}

ts_task_cmd_queue_t* ts_get_task_cmd_queues(uint8_t priority)
{
	memset_s(&tsTaskCmd[priority],sizeof(ts_task_cmd_queue_t),0,sizeof(ts_task_cmd_queue_t));
	tsTaskCmd[priority].read_idx=0;
	tsTaskCmd[priority].write_idx++;
	return &tsTaskCmd[priority];
}

extern ts_task_report_queue_t *ts_get_task_report_queue()
{
    if (tsReport.read_idx > 1024)
        tsReport.read_idx = 0;
    if (tsReport.write_idx > 1024)
        tsReport.write_idx = 0;
    tsReport.write_idx = (tsReport.write_idx + 1) % 1024;
	return &tsReport;
}

void ts_trigger_interrupt(ts_interrupt_num_t interruptID)
{

}

extern "C" void start_task_scheduler()
{
}

extern "C" void stop_task_scheduler()
{
}

modelInitStatus_t modelInit( char * fileName, uint32_t chip_num)
{
    return MODEL_INIT_SUCCESS;
}

void modelRun()
{
}

void startModel(const char *  filepath_, uint64_t * esl_bus[], uint32_t chip_num)
{
}

void stopModel()
{
}
#ifndef __DRV_CFG_DEV_PLATFORM_ESL__
typedef void(*DriverReportIrqTriger)(uint32_t);
extern "C" void tsRegDrvReportIrqTriger(DriverReportIrqTriger irqTriger)
{
     setenv("CAMODEL_LOG_PATH", "model", 1);
}
#endif
