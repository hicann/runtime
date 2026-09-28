# EE1026 Execution\_Error\_Event\_Synchronize\_Timeout

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: Event ID, error cause.

```text
Event (event_id=%s) synchronization timeout. %s
```

Error example:

```text
Event (event_id=5) synchronization timeout. A timeout occurred when waiting for task execution before Event Record. The timeout interval is 1000 ms, device_id=0.
```

## Possible Cause

1. Tasks submitted before the last Event Record take a long time to execute, fail to be executed, or have unsolved dependency relationships.
2. The synchronization timeout interval is less than the time required for completing tasks submitted before the last Event Record.
3. For IPC Event, the peer process or device stops running.

## Solution

1. Check whether tasks submitted before the last Event Record fail to be executed or have unsolved dependency relationships.
2. Extend the synchronization timeout interval via an event timeout interval configuration API (for example, aclrtSynchronizeEventWithTimeout).
3. For IPC Event, ensure that the peer process and device are running properly.
