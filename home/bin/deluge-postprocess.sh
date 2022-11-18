#!/bin/sh -xu




# INPUTS
ARG_PATH="$3/$2"
ARG_NAME="$2"
ARG_LABEL="N/A"



# CONFIG
# Script is called by deluge user, $HOME will not work.
# Use full paths - example: /home/<username>/media.
CONFIG_OUTPUT="/home/dopeman/Logs"

# Logfile: amc.log
# View: cat /var/lib/deluge/.filebot/logs/amc.log
# Excludelist: amc.txt
filebot -script fn:amc \
  --output "$CONFIG_OUTPUT" \
  --action duplicate \
  --conflict skip \
  -non-strict \
  --log-file amc.log \
  --def \
	excludeList=amc.txt \
	unsorted=y \
	"exec=chmod -R 775 \"{folder}/\" ; chown -R deluge:deluge \"{folder}/\"" \
	ut_dir="$ARG_PATH" \
	ut_kind="multi" \
	ut_title="$ARG_NAME" \
	ut_label="$ARG_LABEL"



#--log-file amc.log
#~/.filebot/logs/amc.log

#--def excludeList=amc.txt
#~/.filebot/logs/amc.txt
#Testing
