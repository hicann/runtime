# E40003 File\_Operation\_Error\_Open

## Symptom

The following is error format. The placeholder %s indicates the file name.

```text
Failed to open the JSON file: %s.
```

Error example:

```text
Failed to open the JSON file: /usr/local/Ascend/cann/ascend-toolkit/opp/built-in/op_impl/ai_core/tbe/kernel/config/fusion_ops.json.
```

## Possible Cause

1. The file has been deleted.
2. You do not have the permission to open the file.
3. The file is locked.

## Solution

Run your program again in a single-user environment, that is, ensure that no other user accesses the file.
