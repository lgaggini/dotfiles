#! /bin/bash
# Author: Lorenzo Gaggini
# Version: 0.1
#
# Get cluster info by ansible and ansible-cmdb

#check input
if [ "$#" -ne 1 ]; then
    echo "usage: cluster_info.sh group | host"
    exit 1
fi

# create tmp dir
tmp_dest=/tmp/${1}_cluster_info
mkdir -p "${tmp_dest}"

# get facts and pretty print by ansible cmdb
ansible "${1}" -m setup --tree "${tmp_dest}" -a 'gather_subset=min,network,virtual,hardware' > /dev/null 2>&1
ansible-cmdb "${tmp_dest}" --template txt_table
