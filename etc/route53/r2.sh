#!/bin/sh
# Original from David Fox:
# https://gist.github.com/dfox/1677405
#
# Script to bind a CNAME to our HOST_NAME in ZONE

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
echo "This script must be run as root" 1>&2
exit 1
fi

# Defaults
TTL=60
#HOST_NAME=`hostname`
HOST_NAME=$(curl http://169.254.169.254/latest/meta-data/hostname)
ZONE=NoZoneDefined

# Load configuration
. /etc/route53/config

# Export access key ID and secret for cli53
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

# Use command line scripts to get instance ID and public hostname
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
#INSTANCE_ID=$(ec2metadata | grep 'instance-id:' | cut -d ' ' -f 2)
#MY_NAME=$HOST_NAME
MY_NAME=$(curl http://169.254.169.254/latest/meta-data/instance-id)
#PUBLIC_HOSTNAME=$(/opt/aws/bin/ec2-metadata | grep 'public-hostname:' | cut -d ' ' -f 2)
PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)

PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

logger "ROUTE53: Setting DNS NS $MY_NAME.$ZONE to $PUBLIC_HOSTNAME"

echo "ROUTE53: Setting DNS NS $MY_NAME.$ZONE to $PUBLIC_HOSTNAME"

# Create a new NS record on Route 53, replacing the old entry if nessesary
echo /usr/bin/cli53 rrdelete "$ZONE" "$MY_NAME"
#/usr/bin/cli53 rrdelete "$ZONE" "$MY_NAME"

echo /usr/bin/cli53 rrcreate "$ZONE" "$MY_NAME" CNAME "$PUBLIC_HOSTNAME" --replace --ttl "$TTL"
/usr/bin/cli53 rrcreate "$ZONE" "php-calc-i-1e67febe" A "54.92.173.238" --replace --ttl "$TTL"
#/usr/bin/cli53 rrcreate "$ZONE" "dancer-frontend-$MY_NAME" A "$PUBLIC_IP" --replace --ttl "$TTL"
#/usr/bin/cli53 rrcreate "$ZONE" "kitchensink-example-$MY_NAME" A "$PUBLIC_IP" --replace --ttl "$TTL"
#/usr/bin/cli53 rrcreate "$ZONE" "php-calc-new-$MY_NAME" A "$PUBLIC_IP" --replace --ttl "$TTL"
#/usr/bin/cli53 rrcreate "$ZONE" "$MY_NAME" CNAME "$PUBLIC_HOSTNAME" --replace --ttl "$TTL"

# Configuring OSE hosts file for oo install
#eval "cat <<< \"$(</home/ec2-user/temp.hosts)\"" 2> temp.out > /root/.config/openshift/.ansible/hosts

# Install OSE v3 using Ansible
#ansible-playbook --inventory-file=/root/.config/openshift/.ansible/hosts /home/ec2-user/openshift-ansible/playbooks/byo/config.yml

[root@ip-10-69-31-5 route53]# vi r2.sh
[root@ip-10-69-31-5 route53]# cat r2.sh
#!/bin/sh
# Original from David Fox:
# https://gist.github.com/dfox/1677405
#
# Script to bind a CNAME to our HOST_NAME in ZONE

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
echo "This script must be run as root" 1>&2
exit 1
fi

# Defaults
TTL=60
#HOST_NAME=`hostname`
HOST_NAME=$(curl http://169.254.169.254/latest/meta-data/hostname)
ZONE=NoZoneDefined

# Load configuration
. /etc/route53/config

# Export access key ID and secret for cli53
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

# Use command line scripts to get instance ID and public hostname
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
#INSTANCE_ID=$(ec2metadata | grep 'instance-id:' | cut -d ' ' -f 2)
#MY_NAME=$HOST_NAME
MY_NAME=$(curl http://169.254.169.254/latest/meta-data/instance-id)
#PUBLIC_HOSTNAME=$(/opt/aws/bin/ec2-metadata | grep 'public-hostname:' | cut -d ' ' -f 2)
PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)

PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

logger "ROUTE53: Setting DNS NS $MY_NAME.$ZONE to $PUBLIC_HOSTNAME"

echo "ROUTE53: Setting DNS NS $MY_NAME.$ZONE to $PUBLIC_HOSTNAME"

# Create a new NS record on Route 53, replacing the old entry if nessesary
echo /usr/bin/cli53 rrdelete "$ZONE" "$MY_NAME"
#/usr/bin/cli53 rrdelete "$ZONE" "$MY_NAME"

echo /usr/bin/cli53 rrcreate "$ZONE" "$MY_NAME" CNAME "$PUBLIC_HOSTNAME" --replace --ttl "$TTL"
/usr/bin/cli53 rrcreate "$ZONE" "php-calc-i-1e67febe" A "54.92.173.238" --replace --ttl "$TTL"
#/usr/bin/cli53 rrcreate "$ZONE" "dancer-frontend-$MY_NAME" A "$PUBLIC_IP" --replace --ttl "$TTL"
#/usr/bin/cli53 rrcreate "$ZONE" "kitchensink-example-$MY_NAME" A "$PUBLIC_IP" --replace --ttl "$TTL"
#/usr/bin/cli53 rrcreate "$ZONE" "php-calc-new-$MY_NAME" A "$PUBLIC_IP" --replace --ttl "$TTL"
#/usr/bin/cli53 rrcreate "$ZONE" "$MY_NAME" CNAME "$PUBLIC_HOSTNAME" --replace --ttl "$TTL"

# Configuring OSE hosts file for oo install
#eval "cat <<< \"$(</home/ec2-user/temp.hosts)\"" 2> temp.out > /root/.config/openshift/.ansible/hosts

# Install OSE v3 using Ansible
#ansible-playbook --inventory-file=/root/.config/openshift/.ansible/hosts /home/ec2-user/openshift-ansible/playbooks/byo/config.yml

