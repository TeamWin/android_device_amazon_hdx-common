#!/system/bin/sh
# Copyright (c) 2009-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

#
# Function to start sensors for DSPS enabled platforms
#
start_sensors()
{
    device=`getprop ro.product.device`
    if [ -c /dev/msm_dsps -o -c /dev/sensors ]; then
        if [ "$device" == "apollo" -o "$device" == "thor" -o \
	     "$device" == "kodiak" -o "$device" == "loki" -o \
	     "$device" == "saturn" ]; then
            mkdir -p /persist/sensors
            touch /persist/sensors/sensors_settings
        fi
        chmod -h 775 /persist/sensors
        chmod -h 664 /persist/sensors/sensors_settings
        chown -h system.root /persist/sensors/sensors_settings

	if [ "$device" == "loki" -o "$device" == "saturn" ]; then
	    mkdir -p /persist/misc/sensors
	    chmod -h 775 /persist/misc/sensors
	fi
        mkdir -p /data/misc/sensors
        chmod -h 775 /data/misc/sensors

        if [ "$device" == "apollo" -o "$device" == "thor" -o \
	     "$device" == "kodiak" -o "$device" == "loki" -o \
	     "$device" == "saturn" ]; then
            if [ ! -s /persist/sensors/sensors_settings ]; then
                # If the settings file is empty, enable sensors HAL
                # Otherwise leave the file with it's current contents
                echo 1 > /persist/sensors/sensors_settings
            fi
        fi
	if [ "$device" == "kodiak" ]; then
	    if [ ! -d /persist/sensor_calibration ]; then
                /system/bin/log -t Sensors -p w /persist/sensor_calibration missing, creating it
                /system/bin/log -t Sensors -p w Some calibration data is permanently lost.
                if ! mkdir -p /persist/sensor_calibration; then
		    /system/bin/log -t Sensors -p e Cannot create /persist/sensor_calibration
                fi
	    fi
        fi
        #bootmode=`cat /proc/idme/bootmode`

        if [ "$device" == "apollo" -o "$device" == "thor" ]; then
            do_cal=`getprop persist.sensors.calibrated`
            if [ "$do_cal" == "" -o "$do_cal" == "0" ]; then
                    if [ -f /persist/sensor_calibration/sns.reg ]; then
                        mv /persist/sensor_calibration/sns.reg  /persist/sensor_calibration/sns.reg.old
                    fi
                    setprop persist.sensors.calibrated 1
            fi

        fi

        if [ "$device" != "kodiak" -o `cat /proc/idme/bootmode` != 2 ]; then
            start sensors
        fi
    fi
}

start_sensors
