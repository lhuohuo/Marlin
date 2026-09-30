#!/usr/bin/env bash
# HX-300 CoreXY — 将自定义配置补丁应用到本分支的 Marlin 默认配置
# 用法：git clone -b hx300-corexy <fork地址> 后，在本脚本所在目录执行 bash apply_hx300_config.sh
set -e
cd "$(dirname "$0")"

if ! git apply --check HX300-custom-config.patch 2>/dev/null; then
  # 已应用过则提示
  if git apply --check -R HX300-custom-config.patch 2>/dev/null; then
    echo "补丁已应用过，无需重复操作。"
    exit 0
  fi
  echo "错误：补丁无法应用到当前配置，请确认分支为 hx300-corexy（基于 Marlin 2.1.x）。" >&2
  exit 1
fi

git apply HX300-custom-config.patch
echo "完成：自定义配置已写入 Marlin/Configuration.h 与 Marlin/Configuration_adv.h"
echo "编译：VS Code + PlatformIO，环境 STM32H743xx_btt"
