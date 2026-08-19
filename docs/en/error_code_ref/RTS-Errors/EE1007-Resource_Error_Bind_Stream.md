# EE1007 Resource\_Error\_Bind\_Stream

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: stream id, error cause.

```text
Failed to bind stream (stream_id=%s). Reason: %s.
```

Error example:

```text
Failed to bind stream (stream_id=1). Reason: The stream is already bound.
```

## Solution

Unbind the stream from the already bound model and then rebind it to the current model.
