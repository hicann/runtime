# EP0004 File\_Operation\_Error\_Parse

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: file name, error cause.

```text
Failed to parse file %s. Reason: %s.
```

Error example:

```text
Failed to parse file /home/test_dump/acl.json. Reason: [json.exception.type_error.302] type must be array, but is string.
```

## Solution

Please check and modify the value as prompted in the Reason.
