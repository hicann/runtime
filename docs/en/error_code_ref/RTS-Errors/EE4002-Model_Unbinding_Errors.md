# EE4002 Model\_Unbinding\_Errors

## Symptom

The following is error format. The placeholder %s indicates the error cause.

```text
Failed to unbind the stream from the model. %s
```

Error example:

```text
Failed to unbind the stream from the model. The specified stream (stream_id=61) is not bound to the current model (model_id=63).
```

## Possible Cause

1. The stream to be unbound is not bound to the model.
2. The model is running.

## Solution

1. Check the code to ensure that the stream to be unbound is bound to the model.
2. Ensure that the model is not running.
