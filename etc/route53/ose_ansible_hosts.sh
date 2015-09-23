#!/bin/sh
# Original from Rick Stewart:
#
# Script to setup Ansible hosts file for OSEv3 installation

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
echo "This script must be run as root" 1>&2
exit 1
fi

# Use command line scripts to get instance ID and public hostname
PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
LOCAL_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
LOCAL_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

cat << EOF > /root/.config/openshift/.ansible/hosts
[OSEv3:children]
masters
nodes

[OSEv3:vars]
ansible_ssh_user=root
product_type=openshift
deployment_type=enterprise
openshift_master_identity_providers=[{'name': 'allow_all', 'login': 'true', 'challenge': 'true', 'kind': 'AllowAllPasswordIdentityProvider', 'apiVersion': 'v1'}]

[etcd]
$LOCAL_HOSTNAME

[masters]
$LOCAL_HOSTNAME openshift_ip=$LOCAL_IP openshift_public_ip=$PUBLIC_IP openshift_hostname=$LOCAL_HOSTNAME openshift_public_hostname=$PUBLIC_HOSTNAME

[nodes]
$PUBLIC_HOSTNAME openshift_scheduleable=False openshift_node_labels="{'region': 'infra', 'zone': 'default'}"
$LOCAL_HOSTNAME openshift_scheduleable=True openshift_node_labels="{'region': 'primary', 'zone': 'east'}"

EOF
