#
# Copyright (C) 2022 The OrangeFox Recovery Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FDEVICE="lenovotab2a7_30hc"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export ALLOW_MISSING_DEPENDENCIES=true
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
    export LC_ALL="C"

    export FOX_R11=1
	export OF_PATCH_AVB20=1
	export OF_USE_MAGISKBOOT=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export OF_NO_MIUI_PATCH_WARNING=1
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
	export OF_FBE_METADATA_MOUNT_IGNORE=1
	export FOX_DELETE_AROMAFM=1
    export OF_USE_SYSTEM_FINGERPRINT=1

    export FOX_BUGGED_AOSP_ARB_WORKAROUND="1510672800"; # Tue Nov 14 15:20:00 GMT 2017
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_NANO_EDITOR=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_ZIP_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export OF_USE_GREEN_LED=1
    export FOX_ENABLE_APP_MANAGER=1
    export OF_USE_TWRP_SAR_DETECT="1"

    # OTA for Custom ROMs
    export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
    export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
    export OF_NO_MIUI_OTA_VENDOR_BACKUP=1
    export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1

	# Quick Backup Defaults
    export OF_QUICK_BACKUP_LIST="/boot;/data;/system_image;"

    # lenovotab2a7_30hc
    export TARGET_ARCH="arm"
    export TARGET_DEVICE_ALT="a7_30hc"

    # R11.1 Settings
    export FOX_VERSION="R11.1_0"
    export OF_MAINTAINER="Sushrut1101"

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
fi

add_lunch_combo omni_${FDEVICE}-eng
