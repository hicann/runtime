# EE1010 Execution\_Error\_Invalid\_Context

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: API name, object name, extended information.

```text
%s execution failed because %s does not belong to the current context. Extended information: %s.
```

Error example:

```text
MemCopy2DAsync execution failed because stream does not belong to the current context. Extended information: stream_id=61, stream_ctx=0x56519b7e0ee0, cur_ctx=0x5651a0428090.
```

## Solution

Please adjust your API parameters based on the prompts in the error message.
