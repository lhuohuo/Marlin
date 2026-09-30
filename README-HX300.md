# HX-300 CoreXY 固件分支说明

本分支（`hx300-corexy`）基于 **Marlin 2.1.x** 稳定分支，是 HX-300 CoreXY 高速 FDM 打印机的 Marlin 备选固件。

> 注意：HX-300 的主固件为 Klipper（见主仓库 lhuohuo/fdm-corexy-3dprinter）。
> Marlin 在高速下的实际打印速度建议 ≤ 150–200 mm/s，输入整形需手动测量调参。

## 获取并编译

```bash
git clone -b hx300-corexy https://github.com/lhuohuo/Marlin.git
cd Marlin
bash apply_hx300_config.sh        # 应用 HX300-custom-config.patch 到默认配置
```

然后使用 VS Code + PlatformIO 打开项目，编译环境选择 `STM32H743xx_btt`，
编译产物 `.pio/build/STM32H743xx_btt/firmware.bin` 拷入 SD 卡，插入 BTT SKR 3 后重启即自动刷写。

## 自定义内容摘要（详见 HX300-custom-config.patch）

- 主板 BOARD_BTT_SKR_V3_0，USB 串口（SERIAL_PORT -1）
- CoreXY 运动学，300×300×300 mm
- TMC2209 ×5（X/Y/Z/Z2/E，UART），X/Y 1.1 A、Z 1.0 A
- BLTouch + Bilinear 网格调平（7×7）+ Z_SAFE_HOMING + 双 Z 自动对齐（G34）
- 输入整形 INPUT_SHAPING_X/Y（默认 40 Hz，请用 M593 按实测调整）
- 断料检测（FIL_RUNOUT_PIN PA9，请核对主板丝印）
- 速度 500 mm/s、加速度 5000 mm/s²、热端 300 °C / 热床 110 °C
- HOST_ACTION_COMMANDS / 高级暂停 / BLTouch Z 偏移微调节

## 校准提醒

- E 轴步距务必做 100 mm 实测校准（M92）。
- NOZZLE_TO_PROBE_OFFSET 需按实际打印头测量修改。
- 输入整形频率需实测（默认 40 Hz 仅起点）。
