#!/bin/bash

set -x
set -e

#CVE for which binaries are generated
export CVENUM=
export ZEPHYR_VERSION=

# Zephyr configuration env variables
export ZEPHYR_SDK_INSTALL_DIR=
export ZEPHYR_BASE_DIR=
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr

# git branch with the CVE and fix for the CVE
export BASE_COMMIT=
export FIX_COMMITS=

# Directories configuration
export DATASET_HOME=
export SAMPLE_HOME=$ZEPHYR_BASE_DIR/samples
export CVE_BUILD_DIR=$DATASET_HOME/$CVENUM 
export OUT_DIR=$DATASET_HOME/$CVENUM/ARC-Boards
export PATCH_DIR=$DATASET_HOME/$CVENUM/patches
export PATCHES=$PATCHES_LIST

# Boards selected for binary generation
export BOARDS="hifive1 litex_vexriscv"
export BOARD_NAMES="SiFive-HiFive1 LiteX-VexRiscv"

# Peripheral samples
export SAMPLE_DIR="$SAMPLE_HOME/bluetooth/beacon $SAMPLE_HOME/bluetooth/central $SAMPLE_HOME/bluetooth/hci_pwr_ctrl
					$SAMPLE_HOME/bluetooth/hci_spi $SAMPLE_HOME/bluetooth/hci_uart $SAMPLE_HOME/bluetooth/hci_usb
					$SAMPLE_HOME/bluetooth/peripheral $SAMPLE_HOME/boards/96b_argonkey/microphone $SAMPLE_HOME/boards/96b_argonkey/sensors
					$SAMPLE_HOME/boards/arc_secure_services $SAMPLE_HOME/boards/bbc_microbit/display $SAMPLE_HOME/boards/bbc_microbit/line_follower_robot
					$SAMPLE_HOME/boards/bbc_microbit/pong $SAMPLE_HOME/boards/bbc_microbit/sound $SAMPLE_HOME/boards/intel_s1000_crb/audio
					$SAMPLE_HOME/boards/intel_s1000_crb/dmic $SAMPLE_HOME/boards/intel_s1000_crb/i2s
					$SAMPLE_HOME/boards/nrf/battery $SAMPLE_HOME/boards/nrf/nrfx $SAMPLE_HOME/boards/nrf/system_off
					$SAMPLE_HOME/boards/olimex_stm32_e407/ccm $SAMPLE_HOME/boards/reel_board/mesh_badge $SAMPLE_HOME/boards/sensortile_box
					$SAMPLE_HOME/boards/ti/cc13x2_cc26x2/system_off $SAMPLE_HOME/boards/up_squared/gpio_counter $SAMPLE_HOME/cpp_synchronization
					$SAMPLE_HOME/display/cfb $SAMPLE_HOME/display/cfb_custom_font $SAMPLE_HOME/display/cfb_shell
					$SAMPLE_HOME/display/grove_display $SAMPLE_HOME/display/lvgl $SAMPLE_HOME/drivers/can
					$SAMPLE_HOME/drivers/counter $SAMPLE_HOME/drivers/crypto $SAMPLE_HOME/drivers/current_sensing
					$SAMPLE_HOME/drivers/dac $SAMPLE_HOME/drivers/display $SAMPLE_HOME/drivers/entropy
					$SAMPLE_HOME/drivers/espi $SAMPLE_HOME/drivers/flash_shell $SAMPLE_HOME/drivers/ht16k33
					$SAMPLE_HOME/drivers/i2c_fujitsu_fram $SAMPLE_HOME/drivers/kscan $SAMPLE_HOME/drivers/kscan_touch
					$SAMPLE_HOME/drivers/lcd_hd44780 $SAMPLE_HOME/drivers/led_apa102 $SAMPLE_HOME/drivers/led_apa102c_bitbang
					$SAMPLE_HOME/drivers/led_lp3943 $SAMPLE_HOME/drivers/led_lp5562 $SAMPLE_HOME/drivers/led_lpd8806
					$SAMPLE_HOME/drivers/led_pca9633 $SAMPLE_HOME/drivers/led_ws2812 $SAMPLE_HOME/drivers/lora/receive
					$SAMPLE_HOME/drivers/lora/send $SAMPLE_HOME/drivers/peci $SAMPLE_HOME/drivers/ps2
					$SAMPLE_HOME/drivers/soc_flash_nrf $SAMPLE_HOME/drivers/spi_flash $SAMPLE_HOME/drivers/spi_fujitsu_fram
					$SAMPLE_HOME/drivers/watchdog $SAMPLE_HOME/mpu/mpu_test $SAMPLE_HOME/net/dhcpv4_client
					$SAMPLE_HOME/net/gptp $SAMPLE_HOME/net/lwm2m_client $SAMPLE_HOME/net/telnet
					$SAMPLE_HOME/net/vlan $SAMPLE_HOME/net/wifi $SAMPLE_HOME/net/wpan_serial
                    $SAMPLE_HOME/philosophers $SAMPLE_HOME/portability/cmsis_rtos_v1/philosophers $SAMPLE_HOME/portability/cmsis_rtos_v1/timer_synchronization
					$SAMPLE_HOME/portability/cmsis_rtos_v2/philosophers $SAMPLE_HOME/portability/cmsis_rtos_v2/timer_synchronization
					$SAMPLE_HOME/posix/eventfd $SAMPLE_HOME/posix/gettimeofday $SAMPLE_HOME/scheduler/metairq_dispatch
					$SAMPLE_HOME/sensor/amg88xx $SAMPLE_HOME/sensor/ams_iAQcore $SAMPLE_HOME/sensor/apds9960
					$SAMPLE_HOME/sensor/bq274xx $SAMPLE_HOME/sensor/fxas21002 $SAMPLE_HOME/sensor/fxos8700-hid
					$SAMPLE_HOME/sensor/hmc5883l $SAMPLE_HOME/sensor/hts221 $SAMPLE_HOME/sensor/lis2dh
					$SAMPLE_HOME/sensor/lps22hb $SAMPLE_HOME/sensor/lsm6dsl $SAMPLE_HOME/sensor/magn_polling
					$SAMPLE_HOME/sensor/sensor_shell $SAMPLE_HOME/sensor/thermometer$SAMPLE_HOME/sensor/vl53l0x
					$SAMPLE_HOME/shields/lmp90100_evb/rtd $SAMPLE_HOME/shields/x_nucleo_iks01a1 $SAMPLE_HOME/shields/x_nucleo_iks01a2
					$SAMPLE_HOME/shields/x_nucleo_iks01a3 $SAMPLE_HOME/shields/x_nucleo_iks02a1 $SAMPLE_HOME/subsys/canbus/canopen
					$SAMPLE_HOME/subsys/canbus/isotp $SAMPLE_HOME/subsys/console/echo $SAMPLE_HOME/subsys/console/getchar
					$SAMPLE_HOME/subsys/console/getline $SAMPLE_HOME/subsys/usb/cdc_acm $SAMPLE_HOME/subsys/usb/cdc_acm_composite
					$SAMPLE_HOME/subsys/usb/console $SAMPLE_HOME/subsys/usb/dfu $SAMPLE_HOME/subsys/usb/hid-cdc
					$SAMPLE_HOME/subsys/usb/hid-mouse $SAMPLE_HOME/subsys/usb/hid $SAMPLE_HOME/subsys/usb/inf
					$SAMPLE_HOME/subsys/usb/mass $SAMPLE_HOME/subsys/usb/testusb $SAMPLE_HOME/subsys/usb/webusb
					$SAMPLE_HOME/synchronization $SAMPLE_HOME/testing/integration $SAMPLE_HOME/userspace/prod_consumer
					$SAMPLE_HOME/userspace/shared_mem $SAMPLE_HOME/video/capture $SAMPLE_HOME/video/tcpserversink"

#run the binary generation shell script
"$CVE_BUILD_DIR/$CVENUM-build.sh" 
