#!/usr/bin/env python3
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
r"""Exercise the production Snapshot APIs with a real NPU and two processes.

Requires Python 3.8+, Linux, and an NPU with its Driver and CANN environment loaded.
RTS_LIBRARY_DIR must contain libacl_rt.so, libruntime.so, libruntime_common.so,
the chip's libruntime_v100/v200/v201.so, and dependencies from the same build.
The test checks /proc/self/maps to reject accidentally loaded older libraries.

Example after loading the CANN environment:
    export LD_LIBRARY_PATH="${RTS_LIBRARY_DIR}:/usr/local/Ascend/driver/lib64/driver:${LD_LIBRARY_PATH}"
    python3 tests/ut/runtime/runtime/test/snapshot_npu_test.py \
        --library-dir "${RTS_LIBRARY_DIR}" --device 0 --criu /path/to/criu --criu-sudo \
        --output snapshot_npu_result.json

The device ID is the logical ID visible to this process. Tests cover pre-init TID
queries, real EE1004 reporting, memory/Stream/Event operations, two-process
queries and Lock/Unlock, callback thread IDs, and Backup/Restore with null args
and flags 0/1. They use production libraries and real NPU operations, without
Runtime or Driver stubs. FAILED targets exit directly to release NPU resources.
User memory allocated by aclrtMalloc is not included in Snapshot content backup,
including with flags=1. After restore the test reloads its input, then checks
readback and operations using the original allocation, Stream, and Event.

Results are PASS, FAIL, or UNSUPPORTED. UNSUPPORTED means the Driver cannot run
that backup operation; it does not count as a successful Backup/Restore test.
Use --require-snapshot for acceptance: UNSUPPORTED then also returns a nonzero
exit code. Successful backup tests always dump and restore the target with CRIU
before calling Runtime Restore. CRIU must support this host's kernel and target
resources; use --criu-sudo when noninteractive sudo is required. CRIU failures
are FAIL, never UNSUPPORTED. Logs and images are retained under --work-dir.
"""

import argparse
import ctypes as c
import json
import os
from pathlib import Path
import pwd
import selectors
import shlex
import shutil
import signal
import subprocess
import sys
import tempfile
import threading
import time


PREFIX = "SNAPSHOT_NPU_RESULT "
PARAM_INVALID = 107000
ACL_PARAM_INVALID = 100000
NOT_SUPPORTED = 207000
RUNNING, LOCKED, BACKED_UP, FAILED = range(4)
CALLBACK = c.CFUNCTYPE(c.c_uint32, c.c_int32, c.c_void_p)


class SnapshotArgs(c.Structure):
    _fields_ = [("flags", c.c_uint32), ("reserved", c.c_char * 60)]


def check(condition, message):
    if not condition:
        raise AssertionError(message)


def emit(**data):
    print(PREFIX + json.dumps(data), flush=True)


def publish(directory, kind, **data):
    """Use regular files so CRIU does not need to checkpoint controller pipes."""
    path = directory / (kind + ".json")
    temporary = path.with_suffix(".tmp")
    temporary.write_text(json.dumps(dict(kind=kind, **data)))
    temporary.replace(path)


def enable_subreaper():
    # Detached CRIU children are adopted here, so their actual exit status can
    # be checked even though the original Popen child has already exited.
    libc = c.CDLL(None, use_errno=True)
    libc.prctl.argtypes = [c.c_int, c.c_ulong, c.c_ulong, c.c_ulong, c.c_ulong]
    libc.prctl.restype = c.c_int
    if libc.prctl(36, 1, 0, 0, 0) != 0:  # PR_SET_CHILD_SUBREAPER
        raise OSError(c.get_errno(), "cannot supervise restored children")


def criu_command(arguments):
    return (["sudo", "-n"] if arguments.criu_sudo else []) + [arguments.criu]


def read_criu_file(arguments, path, limit=8000):
    """CRIU creates its pidfile and detailed logs as root when sudo is used."""
    try:
        return path.read_bytes()[-limit:].decode(errors="replace")
    except FileNotFoundError:
        return ""
    except PermissionError:
        if not arguments.criu_sudo:
            raise
        completed = subprocess.run(["sudo", "-n", "tail", "-c", str(limit), "--", str(path)],
                                   stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True,
                                   timeout=min(arguments.criu_timeout, 15), check=True)
        return completed.stdout


def prepare_criu(arguments):
    """Reject unusable CRIU commands before any target or device is created."""
    candidate = os.path.expandvars(os.path.expanduser(arguments.criu))
    if "/" not in candidate:
        candidate = shutil.which(candidate)
        check(candidate is not None, f"CRIU executable {arguments.criu!r} was not found in PATH; "
              "pass --criu /absolute/path/to/the/criu/executable")
    path = Path(candidate).resolve()
    check(not path.is_dir(), f"--criu points to a directory: {path}; specify the executable file")
    check(path.is_file(), f"CRIU executable does not exist: {path}")
    check(os.access(path, os.X_OK), f"CRIU file is not executable: {path}")
    if arguments.criu_sudo:
        check(shutil.which("sudo") is not None, "--criu-sudo requires sudo in PATH")
    arguments.criu = str(path)
    command = criu_command(arguments) + ["--version"]
    try:
        completed = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                   text=True, timeout=min(arguments.criu_timeout, 15), check=False)
    except (OSError, subprocess.TimeoutExpired) as error:
        raise RuntimeError(f"Cannot start CRIU: {shlex.join(command)}: {error}") from error
    output = completed.stdout.strip()
    check(completed.returncode == 0,
          f"CRIU startup check failed ({completed.returncode}): {shlex.join(command)}\n{output}\n"
          "Check the executable, its interpreter/shared libraries, and noninteractive sudo access. "
          "sudo may remove LD_LIBRARY_PATH from the environment.")
    check("Version:" in output, f"Not a CRIU version response: {shlex.join(command)}\n{output}")
    return dict(executable=arguments.criu, version=output)


class Api:
    def __init__(self, directory, with_acl=True):
        self.runtime = c.CDLL(str(directory / "libruntime.so"), mode=c.RTLD_GLOBAL)
        self.bind(self.runtime, "rtSnapShotProcessGetRestoreThreadId", [c.POINTER(c.c_int32)])
        self.bind(self.runtime, "rtPeekAtLastError", [c.c_int])
        if not with_acl:
            return
        self.acl = c.CDLL(str(directory / "libacl_rt.so"), mode=c.RTLD_GLOBAL)
        signatures = {
            "aclInit": [c.c_char_p], "aclFinalize": [], "aclrtSetDevice": [c.c_int],
            "aclrtResetDevice": [c.c_int], "aclrtMalloc": [c.POINTER(c.c_void_p), c.c_size_t, c.c_int],
            "aclrtFree": [c.c_void_p],
            "aclrtMemcpy": [c.c_void_p, c.c_size_t, c.c_void_p, c.c_size_t, c.c_int],
            "aclrtMemsetAsync": [c.c_void_p, c.c_size_t, c.c_int, c.c_size_t, c.c_void_p],
            "aclrtCreateStream": [c.POINTER(c.c_void_p)], "aclrtDestroyStream": [c.c_void_p],
            "aclrtCreateEvent": [c.POINTER(c.c_void_p)], "aclrtDestroyEvent": [c.c_void_p],
            "aclrtRecordEvent": [c.c_void_p, c.c_void_p], "aclrtSynchronizeEvent": [c.c_void_p],
            "aclrtSnapshotProcessGetState": [c.c_int, c.POINTER(c.c_int)],
            "aclrtSnapshotProcessGetRestoreThreadId": [c.c_int, c.POINTER(c.c_int)],
            "aclrtSnapShotProcessLock": [c.c_int, c.c_void_p],
            "aclrtSnapShotProcessUnlock": [c.c_int, c.c_void_p],
            "aclrtSnapShotProcessBackup": [c.c_int, c.POINTER(SnapshotArgs)],
            "aclrtSnapShotProcessRestore": [c.c_int, c.POINTER(SnapshotArgs)],
            "aclrtSnapShotCallbackRegister": [c.c_int, CALLBACK, c.c_void_p],
            "aclrtSnapShotCallbackUnregister": [c.c_int, CALLBACK],
        }
        for name, arguments in signatures.items():
            self.bind(self.acl, name, arguments)
        self.bind(self.acl, "aclGetRecentErrMsg", [], c.c_char_p)

    @staticmethod
    def bind(library, name, arguments, result=c.c_int):
        function = getattr(library, name)
        function.argtypes, function.restype = arguments, result

    def ok(self, name, *arguments):
        result = getattr(self.acl, name)(*arguments)
        check(result == 0, f"{name} returned {result}")

    def state(self, pid):
        state = c.c_int(-1)
        self.ok("aclrtSnapshotProcessGetState", pid, c.byref(state))
        return state.value


class DeviceResources:
    def __init__(self, api, device):
        self.api, self.device = api, device
        self.memory, self.stream, self.event = c.c_void_p(), c.c_void_p(), c.c_void_p()
        self.pattern = bytes((index * 31 + 7) % 256 for index in range(4096))
        self.host = c.create_string_buffer(self.pattern, len(self.pattern))
        api.ok("aclInit", None)
        api.ok("aclrtSetDevice", device)
        api.ok("aclrtMalloc", c.byref(self.memory), len(self.pattern), 2)
        api.ok("aclrtCreateStream", c.byref(self.stream))
        api.ok("aclrtCreateEvent", c.byref(self.event))
        api.ok("aclrtMemcpy", self.memory, len(self.pattern), self.host, len(self.pattern), 1)

    def verify(self, reload_user_data=False):
        if reload_user_data:
            # aclrtMalloc uses SNAPSHOT_NO_BACKUP. Like ACL_SNAPSHOT_0005,
            # reload application data after restore before checking usability.
            # Keep the original allocation, stream and event under test.
            self.api.ok("aclrtMemcpy", self.memory, len(self.pattern), self.host, len(self.pattern), 1)
        output = c.create_string_buffer(len(self.pattern))
        self.api.ok("aclrtMemcpy", output, len(self.pattern), self.memory, len(self.pattern), 2)
        check(output.raw == self.pattern, "NPU memory readback differs after H2D reload" if reload_user_data
              else "NPU memory contents changed")
        self.api.ok("aclrtMemsetAsync", self.memory, len(self.pattern), 0x5A, len(self.pattern), self.stream)
        self.api.ok("aclrtRecordEvent", self.event, self.stream)
        self.api.ok("aclrtSynchronizeEvent", self.event)
        self.api.ok("aclrtMemcpy", output, len(self.pattern), self.memory, len(self.pattern), 2)
        check(output.raw == bytes([0x5A]) * len(self.pattern), "NPU asynchronous operation failed")
        self.api.ok("aclrtMemcpy", self.memory, len(self.pattern), self.host, len(self.pattern), 1)

    def close(self):
        self.api.ok("aclrtDestroyEvent", self.event)
        self.api.ok("aclrtDestroyStream", self.stream)
        self.api.ok("aclrtFree", self.memory)
        self.api.ok("aclrtResetDevice", self.device)
        self.api.ok("aclFinalize")


def loaded_libraries(directory):
    names = ["libruntime.so", "libruntime_common.so", "libacl_rt.so"]
    implementations = ["libruntime_v100.so", "libruntime_v200.so", "libruntime_v201.so"]
    maps = Path("/proc/self/maps").read_text().splitlines()
    paths = sorted({line.split()[-1] for line in maps
                    if line.split()[-1].endswith(tuple(names + implementations))})
    for name in names:
        check(str((directory / name).resolve()) in paths, f"new {name} was not loaded: {paths}")
    selected = [path for path in paths if Path(path).name in implementations]
    check(bool(selected), "no Runtime implementation library was loaded")
    for path in selected:
        check(path == str((directory / Path(path).name).resolve()), f"old Runtime implementation loaded: {path}")
    return paths


def wait_local_service_tid(api):
    # Runtime startup does not wait for the service thread to publish its TID.
    deadline = time.monotonic() + 5
    while True:
        tid = c.c_int32(-1)
        result = api.runtime.rtSnapShotProcessGetRestoreThreadId(c.byref(tid))
        if result == 0:
            check(tid.value > 0, "query returned an invalid service TID")
            return tid.value
        check(result == 507000 and tid.value == -1,
              f"unexpected pre-init TID query result: {result}, tid={tid.value}")
        check(time.monotonic() < deadline, "Snapshot service TID was not published within 5 seconds")
        time.sleep(0.01)


def worker(arguments):
    directory = Path(arguments.library_dir)
    if arguments.worker == "preinit":
        api = Api(directory, with_acl=False)
        tid = wait_local_service_tid(api)
        check(Path(f"/proc/self/task/{tid}/comm").read_text().strip() == "RT_SNAPSHOT",
              "Snapshot service thread name is not RT_SNAPSHOT")
        check(api.runtime.rtSnapShotProcessGetRestoreThreadId(None) == PARAM_INVALID, "null output accepted")
        endpoint = Path(pwd.getpwuid(os.geteuid()).pw_dir) / ".cann_snapshot" / f"{os.getpid()}.sock"
        check(endpoint.is_socket(), "Runtime initialization did not start the Snapshot service")
        emit(kind="result", scenario="preinit", status="PASS", tid=tid)
        return
    api = Api(directory)
    resources = DeviceResources(api, arguments.device)
    resources.verify()
    libraries = loaded_libraries(directory)
    callback_tids = []

    @CALLBACK
    def callback(_device, _data):
        callback_tids.append(threading.get_native_id())
        return 0

    api.ok("aclrtSnapShotCallbackRegister", 0, callback, None)
    service_tid = c.c_int(-1)
    api.ok("aclrtSnapshotProcessGetRestoreThreadId", os.getpid(), c.byref(service_tid))
    check(Path(f"/proc/self/task/{service_tid.value}").exists(), "service TID is not a live target thread")
    if arguments.worker == "local":
        check(api.runtime.rtSnapShotProcessGetRestoreThreadId(None) == PARAM_INVALID, "null TID output accepted")
        check(api.runtime.rtPeekAtLastError(0) == PARAM_INVALID, "last error was not recorded")
        message = api.acl.aclGetRecentErrMsg() or b""
        check(b"EE1004" in message and b"tid" in message, f"missing null-output diagnostic: {message!r}")
        api.ok("aclrtSnapShotProcessLock", os.getpid(), None)
        check(api.state(os.getpid()) == LOCKED, "local Lock did not commit LOCKED")
        api.ok("aclrtSnapShotProcessUnlock", os.getpid(), None)
        check(api.state(os.getpid()) == RUNNING, "local Unlock did not commit RUNNING")
        check(callback_tids == [threading.get_native_id()], "local callback ran on the wrong thread")
        resources.verify()
        api.ok("aclrtSnapShotCallbackUnregister", 0, callback)
        resources.close()
        emit(kind="result", scenario="local", status="PASS", libraries=libraries)
        return
    control = Path(arguments.control_dir)
    restored = False
    publish(control, "ready", pid=os.getpid(), tid=service_tid.value, libraries=libraries)
    while True:
        command_file = control / "command.json"
        if not command_file.exists():
            time.sleep(0.05)
            continue
        command = json.loads(command_file.read_text())["command"]
        command_file.unlink()
        if command == "resumed":
            restored = True
            publish(control, "resumed", pid=os.getpid(), tid=service_tid.value,
                    thread_alive=Path(f"/proc/self/task/{service_tid.value}").exists())
        elif command == "verify":
            resources.verify(reload_user_data=restored)
            check(callback_tids and all(tid == service_tid.value for tid in callback_tids),
                  f"remote callback did not execute on Snapshot service thread: {callback_tids}")
            publish(control, "verified", callbacks=len(callback_tids), user_memory_reloaded=restored)
        elif command == "quit":
            api.ok("aclrtSnapShotCallbackUnregister", 0, callback)
            resources.close()
            publish(control, "closed")
            return
        elif command == "abort":
            # FAILED forbids normal Runtime operations; process exit releases its NPU resources.
            os._exit(0)
        else:
            raise AssertionError(f"unknown controller command: {command}")


def receive(process, expected, timeout=90):
    with selectors.DefaultSelector() as selector:
        selector.register(process.stdout, selectors.EVENT_READ)
        while selector.select(timeout):
            line = process.stdout.readline()
            check(bool(line), f"worker exited while waiting for {expected}, status={process.poll()}")
            if line.startswith(PREFIX.encode()):
                message = json.loads(line[len(PREFIX):])
                check(message.get("kind") == expected, f"expected {expected}: {message}")
                return message
            print(line.decode(errors="replace").rstrip(), flush=True)
    raise TimeoutError(f"worker did not report {expected}")


class Target:
    """Control both the original target and the process rebuilt by CRIU."""

    def __init__(self, command, directory):
        self.directory = directory
        self.log = directory / "target.log"
        command = command + ["--control-dir", str(directory)]
        with self.log.open("wb") as output:
            self.original = subprocess.Popen(command, stdin=subprocess.DEVNULL, stdout=output,
                                             stderr=output, start_new_session=True)
        self.pid = self.original.pid
        self.restored = False
        self.exit_status = None

    def send(self, command):
        check(not (self.directory / "command.json").exists(), "previous command was not consumed")
        publish(self.directory, "command", command=command)

    def receive(self, kind, timeout=90):
        deadline = time.monotonic() + timeout
        while time.monotonic() < deadline:
            error = self.directory / "error.json"
            check(not error.exists(), f"target failed: {error.read_text() if error.exists() else ''}")
            message = self.directory / (kind + ".json")
            if message.exists():
                return json.loads(message.read_text())
            check(self.wait(timeout=0) is None, f"target exited before {kind}; see {self.log}")
            time.sleep(0.05)
        raise TimeoutError(f"target did not report {kind}; see {self.log}")

    def wait(self, timeout=30):
        if not self.restored:
            if timeout == 0:
                return self.original.poll()
            return self.original.wait(timeout=timeout)
        deadline = time.monotonic() + timeout
        while self.exit_status is None:
            pid, status = os.waitpid(self.pid, os.WNOHANG)
            if pid:
                self.exit_status = os.WEXITSTATUS(status) if os.WIFEXITED(status) else -os.WTERMSIG(status)
            elif time.monotonic() >= deadline:
                if timeout == 0:
                    return None
                raise TimeoutError(f"restored target {self.pid} did not exit")
            else:
                time.sleep(0.05)
        return self.exit_status

    def close(self):
        if not self.restored:
            if self.original.poll() is None:
                self.original.kill()
            self.original.wait(timeout=30)
            return
        try:
            if self.wait(timeout=0) is None:
                # waitpid returning zero proves this PID is our live child.
                # Until it is reaped its PID cannot be reused. A process may
                # change its command line, so argv is not an identity check.
                os.kill(self.pid, signal.SIGKILL)
                self.wait()
        except ChildProcessError:
            # Failed restore may have rolled back its child. Never signal a
            # live PID when waitpid cannot establish that it is ours.
            check(not Path(f"/proc/{self.pid}").exists(),
                  f"Cannot clean up PID {self.pid}: it is not a child of controller {os.getpid()}")
        except ProcessLookupError:
            pass


def criu_restart(arguments, target, result):
    """The original must exit; Runtime Restore may only run after real CRIU restore."""
    images = target.directory / "images"
    images.mkdir()
    pidfile = target.directory / "restored.pid"
    # CRIU creates this with O_EXCL; precreating it makes restore fail.
    check(not pidfile.exists(), f"CRIU pidfile already exists: {pidfile}")
    prefix = criu_command(arguments)
    details = dict(images=str(images), commands=[])
    result["criu"] = details

    def run(operation, *options):
        result["phase"] = "criu_" + operation
        command = prefix + [operation, "--images-dir", str(images), "--shell-job",
                            "--log-file", operation + ".log", "-v4"] + list(options)
        record = dict(command=command)
        details["commands"].append(record)
        log = target.directory / ("criu-" + operation + ".log")
        with log.open("wb") as output:
            try:
                completed = subprocess.run(command, stdout=output, stderr=output,
                                           timeout=arguments.criu_timeout, check=False)
            except (OSError, subprocess.TimeoutExpired) as error:
                record["error"] = str(error)
                raise RuntimeError(f"CRIU {operation} failed: {error}; see {log}") from error
        record["returncode"] = completed.returncode
        if completed.returncode != 0:
            output = read_criu_file(arguments, log, 4000)
            output += read_criu_file(arguments, images / (operation + ".log"))
            raise RuntimeError(f"CRIU {operation} returned {completed.returncode}: {shlex.join(command)}\n"
                               f"{output}\nSee {log} and {images}")

    run("dump", "--tree", str(target.pid), "--ext-unix-sk")
    result["phase"] = "wait_original_exit"
    target.original.wait(timeout=30)
    details["original_exited"] = True
    target.restored = True
    run("restore", "--restore-detached", "--pidfile", str(pidfile))
    result["phase"] = "confirm_restored_pid"
    restored_pid = int(read_criu_file(arguments, pidfile).strip())
    check(restored_pid == target.pid, f"CRIU changed target PID: {target.pid} -> {restored_pid}")
    result["phase"] = "wait_restored_target"
    target.send("resumed")
    resumed = target.receive("resumed")
    check(resumed["pid"] == target.pid and resumed["thread_alive"],
          f"CRIU did not restore the target and Snapshot thread: {resumed}")
    details.update(restored_pid=restored_pid, target_resumed=True)
    return resumed


def scenario(arguments, name):
    worker_mode = name if name in ("preinit", "local") else "target"
    command = [sys.executable, __file__, "--library-dir", arguments.library_dir,
               "--device", str(arguments.device), "--worker", worker_mode]
    if worker_mode != "target":
        process = subprocess.Popen(command, stdin=subprocess.DEVNULL, stdout=subprocess.PIPE,
                                   stderr=subprocess.STDOUT, bufsize=0)
        try:
            result = receive(process, "result")
            check(process.wait(timeout=30) == 0, "worker cleanup failed")
            return result
        finally:
            if process.poll() is None:
                process.kill()
            process.wait(timeout=30)
            process.stdout.close()
    directory = Path(arguments.work_dir) / name
    directory.mkdir()
    target = Target(command, directory)
    endpoint = Path(pwd.getpwuid(os.geteuid()).pw_dir) / ".cann_snapshot" / f"{target.pid}.sock"
    result = dict(kind="result", scenario=name, status="FAIL", phase="target_start", work_dir=str(directory))
    try:
        ready = target.receive("ready")
        result["phase"] = "query_target"
        api = Api(Path(arguments.library_dir))
        pid = ready["pid"]
        tid = c.c_int(-1)
        api.ok("aclrtSnapshotProcessGetRestoreThreadId", pid, c.byref(tid))
        check(tid.value == ready["tid"], "remote query returned a different TID")
        check(api.state(pid) == RUNNING, "target did not start in RUNNING")
        result["phase"] = "lock"
        api.ok("aclrtSnapShotProcessLock", pid, None)
        check(api.state(pid) == LOCKED, "remote Lock did not commit LOCKED")
        check(api.acl.aclrtSnapShotProcessLock(pid, None) != 0, "duplicate Lock succeeded")
        result["phase"] = "check_invalid_flags"
        invalid = SnapshotArgs(2)
        check(api.acl.aclrtSnapShotProcessBackup(pid, c.byref(invalid)) == ACL_PARAM_INVALID,
              "invalid Backup flags were not rejected")
        check(api.state(pid) == LOCKED, "invalid Backup flags changed target state")
        result.update(target_pid=pid, target_tid=tid.value, libraries=ready["libraries"])
        if name != "remote":
            result["phase"] = "backup"
            options = None if name == "legacy" else c.byref(SnapshotArgs(int(name[-1])))
            backup = api.acl.aclrtSnapShotProcessBackup(pid, options)
            result["backup_result"] = backup
            if backup != 0:
                state = api.state(pid)
                result.update(status="UNSUPPORTED" if backup == NOT_SUPPORTED else "FAIL", state=state)
                check(backup == NOT_SUPPORTED, f"unexpected Backup failure: {result}")
                check(state == FAILED, "Backup failure did not commit FAILED")
                check(api.acl.aclrtSnapShotProcessUnlock(pid, None) != 0, "FAILED target accepted Unlock")
                target.send("abort")
                check(target.wait() == 0, "FAILED target exit failed")
                return result
            else:
                check(api.state(pid) == BACKED_UP, "Backup did not commit BACKED_UP")
                resumed = criu_restart(arguments, target, result)
                result["phase"] = "query_restored_target"
                check(resumed["tid"] == tid.value, "CRIU changed the Snapshot service TID")
                check(api.state(pid) == BACKED_UP, "CRIU did not preserve BACKED_UP")
                restored_tid = c.c_int(-1)
                api.ok("aclrtSnapshotProcessGetRestoreThreadId", pid, c.byref(restored_tid))
                check(restored_tid.value == tid.value, "restored Snapshot service TID query failed")
                result["phase"] = "runtime_restore"
                api.ok("aclrtSnapShotProcessRestore", pid, options)
                check(api.state(pid) == LOCKED, "Restore did not commit LOCKED")
        result["phase"] = "unlock"
        api.ok("aclrtSnapShotProcessUnlock", pid, None)
        check(api.state(pid) == RUNNING, "remote Unlock did not commit RUNNING")
        result["phase"] = "verify"
        target.send("verify")
        result.update(target.receive("verified"))
        result["kind"] = "result"
        result["phase"] = "target_exit"
        target.send("quit")
        target.receive("closed")
        check(target.wait() == 0, "target cleanup failed")
        result["phase"] = "check_socket_cleanup"
        check(not endpoint.exists(), "normal target exit left its socket endpoint")
        result.update(status="PASS", phase="complete")
        return result
    except Exception as error:
        result.update(status="FAIL", error=str(error))
        return result
    finally:
        try:
            target.close()
            # A deliberately aborted FAILED target cannot run normal finalizers.
            if endpoint.is_socket() and endpoint.stat().st_uid == os.geteuid():
                endpoint.unlink()
        except Exception as error:
            # Preserve the original failure; cleanup must not replace its
            # phase, CRIU diagnostics, or target PID in the returned result.
            result["cleanup_error"] = str(error)
            if result["status"] != "FAIL":
                result.update(status="FAIL", phase="cleanup", error=str(error))


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--library-dir", required=True, help="directory containing newly built production libraries")
    parser.add_argument("--device", type=int, default=0, help="logical device ID")
    parser.add_argument("--worker", choices=["preinit", "local", "target"], help=argparse.SUPPRESS)
    parser.add_argument("--control-dir", help=argparse.SUPPRESS)
    parser.add_argument("--require-snapshot", action="store_true", help="fail when the driver cannot back up resources")
    parser.add_argument("--criu", default="criu", help="CRIU executable used after each successful Backup")
    parser.add_argument("--criu-sudo", action="store_true", help="run CRIU through sudo -n")
    parser.add_argument("--criu-timeout", type=float, default=120, help="timeout in seconds for each CRIU command")
    parser.add_argument("--work-dir", help="new directory for target logs and CRIU images (retained after the run)")
    parser.add_argument("--scenario", action="append",
                        choices=["preinit", "local", "remote", "legacy", "args0", "args1"],
                        help="run only the selected scenario; repeat to select more (default: all)")
    parser.add_argument("--output", help="write a JSON result file")
    arguments = parser.parse_args()
    if arguments.worker:
        try:
            worker(arguments)
        except Exception as error:
            if arguments.control_dir:
                publish(Path(arguments.control_dir), "error", error=str(error))
            raise
        return 0
    results = []
    scenarios = arguments.scenario or ["preinit", "local", "remote", "legacy", "args0", "args1"]
    try:
        check(arguments.criu_timeout > 0, "--criu-timeout must be positive")
        directory = Path(arguments.library_dir).expanduser().resolve()
        for name in ["libacl_rt.so", "libruntime.so", "libruntime_common.so"]:
            check((directory / name).is_file(), f"Missing {directory / name}; --library-dir must be a real "
                  'library directory. Use "$RTS_LIBRARY_DIR", including the $ when referring to a shell variable.')
        arguments.library_dir = str(directory)
        if any(name in scenarios for name in ["legacy", "args0", "args1"]):
            emit(kind="preflight", status="PASS", criu=prepare_criu(arguments))
        if arguments.work_dir:
            directory = Path(arguments.work_dir).expanduser().resolve()
            directory.mkdir(mode=0o700, parents=True)
        else:
            directory = Path(tempfile.mkdtemp(prefix="snapshot-npu-"))
        arguments.work_dir = str(directory)
        enable_subreaper()
    except Exception as error:
        result = dict(scenario="preflight", status="FAIL", error=str(error))
        emit(**result)
        results.append(result)
        if arguments.output:
            Path(arguments.output).write_text(json.dumps(results, indent=2) + "\n")
        return 1
    for name in scenarios:
        try:
            result = scenario(arguments, name)
        except Exception as error:
            result = dict(scenario=name, status="FAIL", error=str(error))
        results.append(result)
        emit(**result)
    if arguments.output:
        Path(arguments.output).write_text(json.dumps(results, indent=2) + "\n")
    return int(any(item["status"] == "FAIL" or
                   (arguments.require_snapshot and item["status"] == "UNSUPPORTED") for item in results))


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as error:
        emit(kind="error", error=str(error))
        # Avoid entering Runtime cleanup while a failed test may still hold Snapshot locks.
        os._exit(1)
