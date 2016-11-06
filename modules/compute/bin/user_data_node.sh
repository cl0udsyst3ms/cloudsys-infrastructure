#!/bin/bash

logger "Setup test node"

logger "Developer user setup"
useradd -m -d /home/developer -s /bin/bash -c "Dev user" -U developer
chown developer:developer /home/developer/.ssh
mkdir -p /home/developer/.ssh
cat /home/developer/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtK+a2DDRcVpRE6ATh2V93ZTNolubGyi+XaObMb6F5gDI0H5IavI9xH3WEGMLr0yIr9PRccDsWRubPV7nb7q6H9agyj55Wmbco9+ERmkKMXG65huAaf+9nvK1yomIvQKqo/bGX30hOrB7xGNLLnNIO9296w7j+hBMX1JCM8Dpoa7T2GI/e8ZhSCLE5OyDnfRcLSkM3NBx2SP+wPsiTL8/4pJDU0b0JP9dJWbUlvV6B1ipvsldfyu+URawbltP5ii3hRobxEoD10jQP1JSlkDorJYE17Lw/TYG0z5Qq5leXGMI+3/xyL6KxWyUnjMsJBWU+ViAaWg9/PFy+3Y4MmS65 developer@miszcz
EOF

echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
