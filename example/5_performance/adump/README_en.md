# adump

The `adump` directory focuses on Dump-related capabilities, currently organized progressively as "operator information statistics -> callback Dump -> configuration-based Dump -> Exception operator Dump":

## File Analysis

For Dump file paths, conversion commands, callback fields, Tensor fields, and analysis suggestions, see [Dump File Analysis](./dump_artifact_analysis_en.md).

## Sample List

- [0_adump_args](./0_adump_args/README_en.md): Use `aclopStartDumpArgs` / `aclopStopDumpArgs` to dump single operator parameters and query the current Dump output path.
- [1_adump_callback](./1_adump_callback/README_en.md): Use `acldumpRegCallback` / `acldumpUnregCallback` to receive Dump data through a callback and demonstrate basic parsing of `acldumpChunk`.
- [2_model_dump_config](./2_model_dump_config/README_en.md): Use `aclmdlInitDump` / `aclmdlSetDump` / `acldumpGetPath` / `aclmdlFinalizeDump` to demonstrate configuration-based Dump.
- [3_save_exception_info](./3_save_exception_info/README_en.md): Use `acldumpGetExceptionInfoPath` / `acldumpSaveExceptionInfo` to actively save custom tensor data to the Exception Dump path.
