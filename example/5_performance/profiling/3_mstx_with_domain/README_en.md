# mstx Sample

## Introduction

This directory contains usage examples for various mstx interfaces. Each folder corresponds to a different use case to help users understand how to use mstx interfaces. The directory and specific use case descriptions are as follows:

| Sample | Description | Supported Products |
| -------------------------------------- | -------------------------------------------------- | ------------------------------------------------------------ |
| mstx_with_domain | Demonstrates the usage of mstx interfaces for marking in default domain and custom domain | Atlas A3 Training Series Products/Atlas A3 Inference Series Products<br/>Atlas A2 Training Series Products/Atlas 800I A2 Inference Products/A200I A2 Box Heterogeneous Components<br/>Atlas 200I/500 A2 Inference Products<br/>Atlas Inference Series Products<br/>Atlas Training Series Products |

## Prerequisites

This example depends on ascend-toolkit. Please confirm that it is installed before use.

## Operation Guide

1. Before use, run `source ${install_path}/set_env.sh` to ensure the example executes properly. `${install_path}` is the CANN installation path. For root installation, the default path is `/usr/local/Ascend/ascend-toolkit`.

2. Change to the directory where the example is located, for example, `/usr/local/Ascend/ascend-toolkit/8.x.x/tools/mstx/samples`.

3. Run the sample_run.sh script in the example directory. The following three scenarios are available:

   - When running the example script sample_run.sh normally, use msprof to configure `--msproftx=on` to collect all marking data (including data within the default domain and user-defined domain ranges). The command is as follows:

     ```bash
     msprof --msproftx=on bash sample_run.sh
     ```

   - You can add the `--mstx-domain-include` switch to control which domain's marking data to collect. For example, to collect only marking data from the "default" domain, configure the command as follows:

     ```bash
     msprof --msproftx=on --mstx-domain-include="default" bash sample_run.sh
     ```

   - You can add the `--mstx-domain-exclude` switch to control which domain's marking data not to collect. For example, to collect marking data excluding the "default" domain, configure the command as follows:

     ```bash
     msprof --msproftx=on --mstx-domain-exclude="default" bash sample_run.sh
     ```

   The `--mstx-domain-include` and `--mstx-domain-exclude` parameters are mutually exclusive and cannot be configured together. To specify multiple domains, separate them with commas.