#!/bin/bash
# function get logs continuously, the download log interval, the directory size and path to store the log are needed
# capture the end signal, perform the final deduplication and exit
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

# 指定shell脚本要监视并拦截的Linux信号。trap命令的格式为：trap commands signals。
trap "last_deduplication; exit" 2 15    # 2: SIGINT 15:SIGTERM

TIME_INTERVAL=$1
LOG_ABSOLUTE_PATH_CAPACITY=$2
LOG_ABSOLUTE_PATH=$3
LOG_CLEAR_FLAG=1
DRIVER_INSTALL_PATH=$(cat /etc/ascend_install.info |grep "Driver_Install_Path_Param" | cut -d "=" -f 2)
DOWNLOAD_LOG_TOOLS_PATH=${DRIVER_INSTALL_PATH}/driver/tools/
DOWNLOAD_LOG_TOOLS=msnpureport
LOG_TMP_DIR_NEW=${LOG_ABSOLUTE_PATH}/msnpureport_log_new
LOG_TMP_DIR_OLD=${LOG_ABSOLUTE_PATH}/msnpureport_log_old
TMP_FILES_DIR=${LOG_ABSOLUTE_PATH}/tmp

# abnormal exit, output tools.log to console and remove tmp and tools.log
function abnormal_exit() {
    # if tools.log exist
    if [ -e "${LOG_ABSOLUTE_PATH}/tools.log" ]; then
        cat ${LOG_ABSOLUTE_PATH}/tools.log
        rm -rf ${LOG_ABSOLUTE_PATH}/tools.log
    fi
    # if tmp/ exist
    if [ -d "${TMP_FILES_DIR}" ]; then
        rm -rf ${TMP_FILES_DIR}
    fi
    exit 1
}

# normal exit
function last_deduplication() {
    append_and_deduplication
    rm -rf ${TMP_FILES_DIR}
    rm -rf ${LOG_ABSOLUTE_PATH}/tools.log
}

function print_log() {
    echo "$(date "+%Y-%m-%d %H:%M:%S.%N" | cut -b 1-23) [RECORD_LOG] [$1] $2"
}

function check_params() {
    re='^[0-9]+$'
    if ! [[ "${TIME_INTERVAL}" =~ $re ]]; then
        print_log "ERROR" "the first param: timeInterval must be integer"
        abnormal_exit
    fi
    if [ $TIME_INTERVAL -le 0 ]; then
        print_log "ERROR" "the first param: timeInterval must be greater than 0"
        abnormal_exit
    fi
    if ! [[ "${LOG_ABSOLUTE_PATH_CAPACITY}" =~ $re ]]; then
        print_log "ERROR" "the second param: logAbsolutePathCapacity must be integer"
        abnormal_exit
    fi
    if [ $LOG_ABSOLUTE_PATH_CAPACITY -le 1 ]; then
        print_log "ERROR" "the second param: logAbsolutePathCapacity must be greater than 1"
        abnormal_exit
    fi
    if [[ "$LOG_ABSOLUTE_PATH" != /* ]]; then
        print_log "ERROR" "the third param: logAbsolutePath must be absolute path"
        abnormal_exit
    fi
    if [ ${LOG_CLEAR_FLAG} -ne 0 ] && [ ${LOG_CLEAR_FLAG} -ne 1 ]; then
        print_log "ERROR" "the forth param: logClearFlag must be 0 or 1"
        abnormal_exit
    fi
}

function get_log_dir_used_space_k() {
    local tmp_dir_size=$(du -sh $1 | awk '{print $1}')
    # handle "du -sh" output 0 (without unit)
    if [ ${tmp_dir_size} = "0" ]; then
        LOG_TMP_DIR_USED_NUM_SIZE_TO_K=0
        return 0
    fi
    LOG_TMP_DIR_USED_SPACE_K=$(echo ${tmp_dir_size} | grep K)
    LOG_TMP_DIR_USED_TAG_K="$?"
    LOG_TMP_DIR_USED_SPACE_M=$(echo ${tmp_dir_size} | grep M)
    LOG_TMP_DIR_USED_TAG_M="$?"
    LOG_TMP_DIR_USED_SPACE_G=$(echo ${tmp_dir_size} | grep G)
    LOG_TMP_DIR_USED_TAG_G="$?"
    LOG_TMP_DIR_USED_SPACE_T=$(echo ${tmp_dir_size} | grep T)
    LOG_TMP_DIR_USED_TAG_T="$?"

    if [ "-${LOG_TMP_DIR_USED_TAG_K}" == "-0" ]; then
        LOG_TMP_DIR_USED_NUM=$(echo ${tmp_dir_size} | awk -F 'K' '{print $1}')
        LOG_TMP_DIR_USED_NUM_SIZE_TO_K=$(awk 'BEGIN{printf "%d\n",'$LOG_TMP_DIR_USED_NUM'}')
    elif [ "-${LOG_TMP_DIR_USED_TAG_M}" == "-0" ]; then
        LOG_TMP_DIR_USED_NUM=$(echo ${tmp_dir_size} | awk -F 'M' '{print $1}')
        LOG_TMP_DIR_USED_NUM_SIZE_TO_K=$(awk 'BEGIN{printf "%d\n",'$LOG_TMP_DIR_USED_NUM' * '1024'}')
    elif [ "-${LOG_TMP_DIR_USED_TAG_G}" == "-0" ]; then
        LOG_TMP_DIR_USED_NUM=$(echo ${tmp_dir_size} | awk -F 'G' '{print $1}')
        LOG_TMP_DIR_USED_NUM_SIZE_TO_K=$(awk 'BEGIN{printf "%d\n",'$LOG_TMP_DIR_USED_NUM' * '1024' * '1024'}')
    elif [ "-${LOG_TMP_DIR_USED_TAG_T}" == "-0" ]; then
        LOG_TMP_DIR_USED_NUM=$(echo ${tmp_dir_size} | awk -F 'T' '{print $1}')
        LOG_TMP_DIR_USED_NUM_SIZE_TO_K=$(awk 'BEGIN{printf "%d\n",'$LOG_TMP_DIR_USED_NUM' * '1024' * '1024' * '1024'}')
    else
        print_log "ERROR" "Space size check fail."
        abnormal_exit
    fi
}

function prepare() {
    # check the absolute path of the incoming storage log
    if [ ! -d "${LOG_ABSOLUTE_PATH}" ]; then
        print_log "WARNING" "The device log ${LOG_ABSOLUTE_PATH} storage path does not exist, will create."
        mkdir -p ${LOG_ABSOLUTE_PATH}
    fi
    mkdir -p -m 750 ${LOG_TMP_DIR_NEW} ${LOG_TMP_DIR_OLD}
    LOG_TMP_DIR_USED_NUM_SIZE_TO_G=0
    if [[ ${LOG_CLEAR_FLAG} -eq 1 ]]; then
        rm -rf ${LOG_TMP_DIR_NEW}/*
        rm -rf ${LOG_TMP_DIR_OLD}/*
    else
        # get size in original directory
        get_log_dir_used_space_k ${LOG_TMP_DIR_NEW}
        ORIGIN_NEW_DIR_USED_SIZE_K=${LOG_TMP_DIR_USED_NUM_SIZE_TO_K}
        get_log_dir_used_space_k ${LOG_TMP_DIR_OLD}
        ORIGIN_OLD_DIR_USED_SIZE_K=${LOG_TMP_DIR_USED_NUM_SIZE_TO_K}
        ORIGIN_DIR_USED_SIZE_K=$(echo "${ORIGIN_NEW_DIR_USED_SIZE_K}+${ORIGIN_OLD_DIR_USED_SIZE_K}" | bc)
        LOG_TMP_DIR_USED_NUM_SIZE_TO_G=$(awk 'BEGIN{printf "%.2f\n",'$ORIGIN_DIR_USED_SIZE_K'/'1024'/'1024'}')
        echo "LOG_TMP_DIR_USED_NUM_SIZE_TO_G="${LOG_TMP_DIR_USED_NUM_SIZE_TO_G}
    fi

    # check the size of the directory where the incoming logs are stored
    MOUNT_DIR=$(df -h ${LOG_ABSOLUTE_PATH} | tail -1 | awk '{print $6}')
    LOG_DIR_MAX_SIZE=$(echo "scale=2; ${LOG_ABSOLUTE_PATH_CAPACITY} / 2"|bc)

    AVAIL_SPACE=$(df -h ${LOG_ABSOLUTE_PATH} | tail -1 | awk '{print $4}')
    AVAIL_SPACE_K=$(echo ${AVAIL_SPACE} | grep K)
    AVAIL_TAG_K="$?"
    AVAIL_SPACE_M=$(echo ${AVAIL_SPACE} | grep M)
    AVAIL_TAG_M="$?"
    AVAIL_SPACE_G=$(echo ${AVAIL_SPACE} | grep G)
    AVAIL_TAG_G="$?"
    AVAIL_SPACE_T=$(echo ${AVAIL_SPACE} | grep T)
    AVAIL_TAG_T="$?"

    if [ "-${AVAIL_TAG_K}" == "-0" ]; then
        AVAIL_NUM=$(df -h ${LOG_ABSOLUTE_PATH} | tail -1 | awk '{print $4}' | awk -F 'K' '{print $1}')
        AVAIL_NUM_SIZE_TO_G=$(awk 'BEGIN{printf "%.2f\n",'$AVAIL_NUM'/'1024'/'1024'}')
    elif [ "-${AVAIL_TAG_M}" == "-0" ]; then
        AVAIL_NUM=$(df -h ${LOG_ABSOLUTE_PATH} | tail -1 | awk '{print $4}' | awk -F 'M' '{print $1}')
        AVAIL_NUM_SIZE_TO_G=$(awk 'BEGIN{printf "%.2f\n",'$AVAIL_NUM'/'1024'}')
    elif [ "-${AVAIL_TAG_G}" == "-0" ]; then
        AVAIL_NUM=$(df -h ${LOG_ABSOLUTE_PATH} | tail -1 | awk '{print $4}' | awk -F 'G' '{print $1}')
        AVAIL_NUM_SIZE_TO_G=$(echo "${AVAIL_NUM} / 1"|bc)
    elif [ "-${AVAIL_TAG_T}" == "-0" ]; then
        AVAIL_NUM=$(df -h ${LOG_ABSOLUTE_PATH} | tail -1 | awk '{print $4}' | awk -F 'T' '{print $1}')
        AVAIL_NUM_SIZE_TO_G=$(echo "${AVAIL_NUM} * 1024"|bc)
    else
        print_log "ERROR" "Mount dir ${MOUNT_DIR} avail space size ${AVAIL_SPACE} check fail."
        abnormal_exit
    fi
    AVAIL_NUM_SIZE_TO_G=$(echo "${AVAIL_NUM_SIZE_TO_G}-${LOG_TMP_DIR_USED_NUM_SIZE_TO_G}" | bc)
    log_abs_path_size=$(awk -v num1=${LOG_ABSOLUTE_PATH_CAPACITY} -v num2=${AVAIL_NUM_SIZE_TO_G} 'BEGIN{print(num1>num2)?"0":"1"}')
    if [ "-${log_abs_path_size}" == "-0" ]; then
        print_log "WARNING" "The device log dir ${LOG_ABSOLUTE_PATH} size : ${LOG_ABSOLUTE_PATH_CAPACITY}G."
        print_log "WARNING" "The device log mount dir ${MOUNT_DIR} size : ${AVAIL_NUM_SIZE_TO_G}G."
        print_log "ERROR" "The device log dir${LOG_ABSOLUTE_PATH} size check fail."
        abnormal_exit
    fi
    print_log "INFO" "The device log dir ${LOG_ABSOLUTE_PATH} size : ${LOG_ABSOLUTE_PATH_CAPACITY}G."
    print_log "INFO" "The device log mount dir ${MOUNT_DIR} size : ${AVAIL_NUM_SIZE_TO_G}G."
    print_log "INFO" "The device log dir ${LOG_ABSOLUTE_PATH} size check pass."

    rm -rf ${TMP_FILES_DIR}/device_log
    mkdir -p ${TMP_FILES_DIR}/device_log
    chmod -R 750 ${TMP_FILES_DIR}
    # check whether the log export tool msnpureport exists
    if [ ! -f "${DOWNLOAD_LOG_TOOLS_PATH}/${DOWNLOAD_LOG_TOOLS}" ]; then
        print_log "ERROR" "Download device log msnpureport tools not exist."
        abnormal_exit
    fi
    print_log "INFO" "Check device log msnpureport tools exist."
}

# cp download logs to result log dir.
function cp_download_logs_to_result_log_dir() {
    num=$(ls $TMP_FILES_DIR/device_log | wc -l)
    if [ "-${num}" != "-1" ]; then
        print_log "ERROR" "${TMP_FILES_DIR}/device_log have $num dir, expect 1 dir, please check download log tools."
        abnormal_exit
    fi
    DIR_TEMPLATE=$(ls ${TMP_FILES_DIR}/device_log)
    if [ "-${DIR_TEMPLATE}" == "-" ]; then
        print_log "ERROR" "Download device log fail."
        abnormal_exit
    fi
    if [ ! -d "${TMP_FILES_DIR}/device_log/${DIR_TEMPLATE}" ]; then
        print_log "ERROR" "Device log Dir not exist."
        abnormal_exit
    fi
    DEVICE_LOG_DIR=${DIR_TEMPLATE}
    print_log "INFO" "Downloading device logs dir is ${TMP_FILES_DIR}/device_log/${DEVICE_LOG_DIR}"

    # determine whether the size of the log storage directory exceeds LOG_ABSOLUTE_PATH_CAPACITY/2, no judgment needed for the first time
    get_log_dir_used_space_k ${LOG_TMP_DIR}
    LOG_TMP_DIR_USED_NUM_SIZE_TO_G=$(awk 'BEGIN{printf "%.2f\n",'${LOG_TMP_DIR_USED_NUM_SIZE_TO_K}'/'1024'/'1024'}')
    log_tmp_dir_size=$(awk -v num1=${LOG_TMP_DIR_USED_NUM_SIZE_TO_G} -v num2=${LOG_DIR_MAX_SIZE} 'BEGIN{print(num1>num2)?"0":"1"}')
    if [ "-${log_tmp_dir_size}" == "-0" ]; then
        print_log "INFO" "msnpureport_log_new size had exceeded ${LOG_DIR_MAX_SIZE}G, will move its contents to msnpureport_log_old."
        rm -rf $LOG_TMP_DIR_OLD/*
        mv $LOG_TMP_DIR_NEW/* $LOG_TMP_DIR_OLD/
    fi
    \cp -rf ${TMP_FILES_DIR}/device_log/${DEVICE_LOG_DIR}/* ${LOG_TMP_DIR_NEW}/
}

# append and de-duplicate in log files history.log, message, message.0
function append_and_deduplication() {
    if [ ! -d "${LOG_TMP_DIR_NEW}/hisi_logs/" ]; then
        print_log "WARNING" "dir ${LOG_TMP_DIR_NEW} does not contains dir hisi_logs, please check"
    else
        touch ${TMP_FILES_DIR}/historyList
        chmod 640 ${TMP_FILES_DIR}/historyList
        find ${LOG_TMP_DIR_NEW}/hisi_logs/ -type f -name history.log > ${TMP_FILES_DIR}/historyList
        NUM_HISTORY=$(cat ${TMP_FILES_DIR}/historyList | wc -l)
        echo "NUM_HISTORY="$NUM_HISTORY
        for((i=1; i<=${NUM_HISTORY}; i++))
        do
            var=$(cat ${TMP_FILES_DIR}/historyList | sed -n "${i}p")
            echo "history_var="$var
            public_path=$(echo ${var%/*})
            echo "$var" | xargs cat >> ${public_path}/history_new.log
            # delete original file history.log
            rm -f ${var}
            # deduplication
            touch ${public_path}/history_new_tmp.log
            chmod 640 ${public_path}/history_new_tmp.log
            awk '!a[$0]++' ${public_path}/history_new.log > ${public_path}/history_new_tmp.log
            cp -f ${public_path}/history_new_tmp.log ${public_path}/history_new.log
            rm -f ${public_path}/history_new_tmp.log
        done
    fi

    if [ ! -d "${LOG_TMP_DIR_NEW}/message/" ]; then
        print_log "WARNING" "dir ${LOG_TMP_DIR_NEW} does not contains dir message, please check"
    else
        touch ${TMP_FILES_DIR}/messageList
        chmod 640 ${TMP_FILES_DIR}/messageList
        find ${LOG_TMP_DIR_NEW}/message/ -type f \( -name "messages" -o -name "messages.0" \) > ${TMP_FILES_DIR}/messageList
        NUM_MESSAGE=$(cat ${TMP_FILES_DIR}/messageList | wc -l)
        echo "NUM_MESSAGE="$NUM_MESSAGE
        for((i=1; i<=${NUM_MESSAGE}; i++))
        do
            var=$(cat ${TMP_FILES_DIR}/messageList | sed -n "${i}p")
            echo "message_var="$var
            public_path=$(echo ${var%/*})
            echo "$var" | xargs cat >> ${public_path}/message_new.log
            # delete original file message, message.0
            rm -f ${var}
            # deduplication
            touch ${public_path}/message_new_tmp.log
            chmod 640 ${public_path}/message_new_tmp.log
            awk '!a[$0]++' ${public_path}/message_new.log > ${public_path}/message_new_tmp.log
            cp -f ${public_path}//message_new_tmp.log ${public_path}/message_new.log
            rm -f ${public_path}//message_new_tmp.log
        done
	fi

    if ls ${LOG_TMP_DIR_NEW}/slog/dev-os-*/device-* &> /dev/null; then
        touch ${TMP_FILES_DIR}/devOsList
        chmod 640 ${TMP_FILES_DIR}/devOsList
        ls ${LOG_TMP_DIR_NEW}/slog/ > ${TMP_FILES_DIR}/devOsList
        for os_line in $(cat ${TMP_FILES_DIR}/devOsList)
        do
            touch ${TMP_FILES_DIR}/deviceList
            chmod 640 ${TMP_FILES_DIR}/deviceList
            ls ${LOG_TMP_DIR_NEW}/slog/$os_line > ${TMP_FILES_DIR}/deviceList
            for device_line in $(cat ${TMP_FILES_DIR}/deviceList)
            do
                if [[ $device_line == device-* ]]; then
                    mkdir -p -m 700 ${LOG_TMP_DIR_NEW}/slog/$os_line/debug/
                    mkdir -p -m 700 ${LOG_TMP_DIR_NEW}/slog/$os_line/debug/$device_line
                    mv -f ${LOG_TMP_DIR_NEW}/slog/$os_line/$device_line/* ${LOG_TMP_DIR_NEW}/slog/$os_line/debug/$device_line
                    rm -rf ${LOG_TMP_DIR_NEW}/slog/$os_line/$device_line
                fi
            done
        done
    fi
}

# collect logs continuously
function collect_log() {
    LOG_TMP_DIR=${LOG_TMP_DIR_NEW}
    for ((j = 0; ; j++))
    do
        print_log "INFO" "Start downloading logs."
        cd ${TMP_FILES_DIR}/device_log
        # download log
        touch ${LOG_ABSOLUTE_PATH}/tools.log
        chmod 640 ${LOG_ABSOLUTE_PATH}/tools.log
        ${DOWNLOAD_LOG_TOOLS_PATH}/${DOWNLOAD_LOG_TOOLS} > ${LOG_ABSOLUTE_PATH}/tools.log
        ret=$(grep "send file hdc client connect failed" ${LOG_ABSOLUTE_PATH}/tools.log | wc -l)    # if contains failed msg
        # abnormal exit
        if [ "-${ret}" != "-0" ]; then
            print_log "ERROR" "Error is reported and exits, check download log"
            abnormal_exit
        fi
        print_log "INFO" "Download device logs succeed."
        cd ${TMP_FILES_DIR}
        # cp download logs to result log dir
        cp_download_logs_to_result_log_dir ${j}
        # append and de-duplicate in log files history.log, message, message.0
        append_and_deduplication
        local tmp_dir_size=$(du -sh ${LOG_TMP_DIR} | awk '{print $1}')
        print_log "INFO" "The device log dir ${LOG_TMP_DIR}, used size : ${tmp_dir_size}, single max size : ${LOG_DIR_MAX_SIZE}G."
        print_log "INFO" "Update log file succeed, tag [$((j+1))]."
        # delete the original download log file
        cd ${TMP_FILES_DIR}/device_log/
        # delete the DIR_TEMPLATE if it is not empty
        [ -d "${DIR_TEMPLATE}" ] && rm -rf ${DIR_TEMPLATE}
        # download interval
        sleep ${TIME_INTERVAL}
    done
}

function main() {
    if [ $# -lt 3 ]; then
        echo -e "Usage:"
        echo -e "    msnpureport_auto_export.sh <OPTIONS>\n"
        echo -e "Options:"
        echo -e "    timeInterval            : Interval for exporting logs."
        echo -e "    logAbsolutePathCapacity : Log save path capacity, unit: GB."
        echo -e "    logAbsolutePath         : Log save path, only absolute paths are supported."
        echo -e "    logClearFlag            : Log clear flag, only 0 or 1 is supported.\n"
        echo -e "Examples:"
        echo -e "    ./msnpureport_auto_export.sh timeInterval logAbsolutePathCapacity logAbsolutePath logClearFlag"
        return 1
    fi
    if [[ $# -ge 4 ]]; then
        LOG_CLEAR_FLAG=$4
    fi
    check_params
    prepare
    collect_log
}

main $1 $2 $3 $4
