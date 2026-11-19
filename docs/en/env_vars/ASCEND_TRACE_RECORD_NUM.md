# ASCEND\_TRACE\_RECORD\_NUM

<!-- md-trans-meta sourceCommit=e1bc2bb7763ac16f654082dfdfe03fc13da9ccab translatedAt=2026-10-22T09:30:48.982Z pushedAt=2026-10-23T08:16:16.684Z -->

## Description

Sets the aging specification of trace log files. The value range is \[10, 1000\].

Specifically, it refers to the aging specification of the `schedule_event_{Current process PID}_{Timestamp when the directory is generated}` subdirectory under the `$HOME/ascend/atrace/trace_{Process group PID}_{PID of the process that initially loads the trace dynamic library}_{Timestamp of the initial load of the trace dynamic library}/` directory. The trace log files on the host side and the trace log files on the device side are counted separately. After configuration, the number of directories on the host and device sides is controlled separately.

## Configuration Example

```sh
export ASCEND_TRACE_RECORD_NUM=15
```

This indicates that a maximum of 15 directories named `schedule_event_{Current process PID}_{Timestamp when the directory is generated}` are generated under `$HOME/ascend/atrace/trace_{Process group PID}_{PID of the process that initially loads the trace dynamic library}_{Timestamp of the initial load of the trace dynamic library}/`. When the number of directories exceeds this limit, directories with older timestamps are automatically deleted.

## Constraints

None

## Supported Models

Supported on all chips.
