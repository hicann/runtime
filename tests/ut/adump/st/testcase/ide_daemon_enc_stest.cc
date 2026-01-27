/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"

#include "ide_common_util.h"
#include "adump_device_pub.h"
#include "ide_daemon_enc_dec.h"
#include "wsecv2_callbacks.h"
#include "wsecv2_itf.h"
#include "sdpv2_itf.h"
#include <fcntl.h>

#include <sys/socket.h>
#include <arpa/inet.h>

#include "ascend_hal.h"
#include "ide_daemon_host_stest.h"
#include "ide_daemon_stub.h"
#include "ide_hdc_stub.h"
#include "ide_common_util.h"
#include "mmpa_stub.h"
#include "ide_daemon_dev.h"
#include "ide_daemon_enc_dec.h"
#include "ide_daemon_hdc.h"
#include "common/config.h"

#include "ide_daemon_dev.h"
#include "ide_daemon_enc_dec.h"
#include "ide_daemon_hdc.h"
#include "adx_dump_record.h"
#include "common/config.h"
#include "adx_dsmi.h"
#include "ide_task_register.h"
#include <vector>


using namespace IdeDaemon::Common::Config;

extern int g_ide_cmd_write_time;
extern int g_ide_cmd_read_time;
extern int g_ide_recv_time;
extern int g_ide_host_type;
extern int g_ide_cmd_recv_time_host1;
extern int g_mmCreateTaskFlag;
extern int g_mmCreateTaskWitchDeatchFlag;
extern int g_ide_daemon_send_file_req;
extern int g_netlink_notify_flag;
extern enum cmd_class g_ide_daemon_host_req_type;
extern"C"{
extern int HdcDaemonServerRegister(uint32_t num, const std::vector<uint32_t> &dev);
extern void *IdeDaemonHdcCreateServerEvent(void *args);
extern int IdeSigError(int signo,const struct sigaction* act,struct sigaction* oact);
extern void IdeDeviceStateNotifierRegister(int (*ide_dev_state_notifier)(devdrv_state_info_t *stateInfo));
}
extern int SingleProcessStart(std::string &lock);

extern std::string GetCfgResolvedPath(const std::string &path);
extern void *Fopen(const char *filePathName, const KmcFileOpenMode mode);
extern int Fwrite(const void *buffer, size_t count, const void *stream);
extern int Fclose(void *stream);
void *sec_file = NULL;
void *sto_file = NULL;
std::string sec_file_s;
std::string sto_file_s;

class IDE_DAEMON_DAEMON_ENC_STEST: public testing::Test {
protected:
	virtual void SetUp() {
        g_ide_cmd_write_time = 0;
        g_ide_cmd_read_time = 0;
        g_ide_recv_time = 0;
        g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
        g_ide_create_task_time = 1;
        g_mmCreateTaskWitchDeatchFlag = 1;
        g_ide_daemon_send_file_req = 0;
        g_netlink_notify_flag = 0;
	}
	virtual void TearDown() {
        GlobalMockObject::verify();
	}
};

static const int ret_size = sizeof(struct IdePack);

static void mocker_common()
{
	MOCKER(IdeFork)
		.stubs()
		.will(returnValue(IDE_DAEMON_OK));

	MOCKER(setsid)
		.stubs()
		.will(returnValue(IDE_DAEMON_OK));

	MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(getifaddrs)
        .stubs()
        .will(invoke(getifaddrs_stub));

    MOCKER(freeifaddrs)
        .stubs()
        .will(invoke(freeifaddrs_stub));

    MOCKER(getnameinfo)
        .stubs()
        .will(invoke(getnameinfo_stub));

    MOCKER(mmSemWait)
        .stubs()
        .will(invoke(mmSemWait_stub));

    MOCKER(SingleProcessStart)
        .stubs()
        .will(returnValue(0));

    g_ide_create_task_time = 1;
}

static void mocker_select()
{
    MOCKER(select)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(-1));
}

WsecErr WsecRegFuncEx_stub(const WsecCallbacks *allCallbacks)
{
    void *filename = NULL;
    char buff[10] = {'a'};
    int endOfFile;
    unsigned char *pEnt;
    time_t curTime;
    struct tm curTm;

    buff[9] = 0;

    allCallbacks->basicRelyCallbacks.writeLog(0, NULL, NULL, 0, NULL);
    allCallbacks->basicRelyCallbacks.notify(0, NULL, 0);
    allCallbacks->basicRelyCallbacks.doEvents();
    allCallbacks->lockCallbacks.createLock(NULL);
    allCallbacks->lockCallbacks.destroyLock(NULL);
    allCallbacks->lockCallbacks.lock(NULL);
    allCallbacks->lockCallbacks.unlock(NULL);
    allCallbacks->procLockCallbacks.createProcLock(NULL);
    allCallbacks->procLockCallbacks.destroyProcLock(NULL);
    allCallbacks->procLockCallbacks.procLock(NULL);
    allCallbacks->procLockCallbacks.procUnlock(NULL);
    filename = allCallbacks->fileCallbacks.fileOpen("test", KMC_FILE_READWRITE_BINARY);
    allCallbacks->fileCallbacks.fileWrite(buff, 9, filename);
    allCallbacks->fileCallbacks.fileRead(buff, 9, filename);
    allCallbacks->fileCallbacks.fileFlush(filename);
    allCallbacks->fileCallbacks.fileSeek(filename, 5, KMC_FILE_SEEK_CUR);
    allCallbacks->fileCallbacks.fileTell(filename);
    allCallbacks->fileCallbacks.fileEof(filename, &endOfFile);
    allCallbacks->fileCallbacks.fileErrno(filename);
    allCallbacks->fileCallbacks.fileExist("filename");
    allCallbacks->fileCallbacks.fileRemove("filename");
    allCallbacks->fileCallbacks.fileClose(filename);
    allCallbacks->rngCallbacks.getEntropy(&pEnt, 10);
    allCallbacks->rngCallbacks.cleanupEntropy(pEnt, 10);
    allCallbacks->timeCallbacks.gmTimeSafe(&curTime, &curTm);

    return WSEC_SUCCESS;

}

extern int TestDecWithKMC(unsigned char *cpr, unsigned int cprlen, unsigned char *pln, unsigned int *plnlen);
TEST_F(IDE_DAEMON_DAEMON_ENC_STEST, IdeDaemonTestMain_cmd)
{
    int argc = 2;
    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
    mocker_common();
    mocker_select();
    MOCKER(HdcCreateHdcServerProc)
        .stubs()
        .will(returnValue((void *) NULL));
    sec_file_s = GetCfgResolvedPath(IDE_DAEMON_SEC);
    sto_file_s = GetCfgResolvedPath(IDE_DAEMON_STO);
    sec_file = Fopen("/tmp/test", KMC_FILE_READWRITE_BINARY);
    Fwrite("test", strlen("test"), sec_file);
    Fclose(sec_file);
    system("mkdir -p ~/ide_daemon");
    std::string cmd = "echo test >> " + sec_file_s;
    system(cmd.c_str());
    cmd = "echo test >> " + sto_file_s;
    system(cmd.c_str());

    MOCKER(WsecRegFuncEx)
        .stubs()
        .will(invoke(WsecRegFuncEx_stub));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_command_process
}
