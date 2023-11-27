#!/usr/local/bin/bash
################################
# Update custom Suricata rules #
# License: AGPL v.3.0 or later #
# Last updated: 2023-11-27     #
################################
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free 
# Software Foundation, either version 3 of the License, or (at your option) any 
# later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT 
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with 
# this program. If not, see <https://www.gnu.org/licenses/>.

########################
# Log file for updates #
########################
log_file="/var/log/ociru_update.log"

#####################
# Rules directories #
#####################
opn_rules="/usr/local/etc/suricata/opnsense.rules/"
rules="/usr/local/etc/suricata/rules/"

###################
# Rule file names #
###################
hunting="hunting.rules"
etn_aggressive="etn_aggressive.rules"

######################
# Rule download URLs #
######################
dl_hunting="https://raw.githubusercontent.com/travisbgreen/hunting-rules/master/${hunting}"
dl_etn_aggressive="https://security.etnetera.cz/feeds/${etn_aggressive}"

#################
# Start Updates #
#################
echo "Starting updates at `date`" | tee -a ${log_file}

####################################
# Use tmp as our working directory #
####################################
cd /tmp
if [ $? -ne 0 ]; then
        echo "Failed to change to /tmp, exiting!" | tee -a ${log_file}
        exit -1
fi

##################
# Download rules #
##################
/usr/local/bin/curl --silent ${dl_hunting} --output ${hunting}
if [ $? -ne 0 ]; then
        echo "Failed to download ${hunting}, exiting!" | tee -a ${log_file}
        exit -2
fi
/usr/local/bin/curl --silent ${dl_etn_aggressive} --output ${etn_aggressive}
if [ $? -ne 0 ]; then
        echo "Failed to download ${etn_aggressive}, exiting!" | tee -a ${log_file}
        exit -3
fi

########################
# Finished Downloading #
########################
echo "Downloads finished at `date`" | tee -a ${log_file}

#########################################
# Copy updated rule files to            #
# Suricata interface rule directories   #
#########################################
echo "Copying ${hunting} ${etn_aggressive} to ${opn_rules}" | tee -a ${log_file}
cp ${hunting} ${etn_aggressive} ${opn_rules}
if [ $? -ne 0 ]; then
        echo "Copy operation for ${opn_rules} failed, exiting!" | tee -a ${log_file}
        exit -4
fi

echo "Copying ${hunting} ${etn_aggressive} to ${rules}" | tee -a ${log_file}
cp ${hunting} ${etn_aggressive} ${rules}
if [ $? -ne 0 ]; then
        echo "Copy operation for ${rules} failed, exiting!" | tee -a ${log_file}
        exit -5
fi

#################
# Done updating #
#################
echo "Completed updates at `date`" | tee -a ${log_file}