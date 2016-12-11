#!/bin/bash

logger "Setup test node"

logger "Developer user setup"
useradd -m -d /home/developer -s /bin/bash -c "Dev user" -U developer
mkdir -p /home/developer/.ssh
chown developer:developer /home/developer/.ssh
touch /home/developer/.ssh/authorized_keys
cat > /home/developer/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrjWABc9Mdq/rfC7NtIRk61OInHy6GFtp0Q7UiIhezWLnXfZrRaXDN/4p5CjkhAIYOL2wJN8sxLPSuGDls1LU7QurJ/mW+Z9yze7t9z86U9VfxARQ6Qn92YQoe1LNxfcwr5oxhhlZRB8sMRonNRtKUELY5h6+t18+JjbpNioydmp+6FS4IvQu7QcNh/XjJF+lIfK+s/kYEUR1RJibVIJhoYRuC17VT/0CiV6sEUOGUsBBztFPDIGPriJKd7uGRthWpNUgVoast4sYXVRlyE/8bXvPSWFNHHrqgFyRA1hu6sv73hjwYW5oEGpVv41/xJaNWS4TnEChWl7vJnnYMbvYB developer@ip-7-7-7-42
EOF

chown developer:developer /home/developer/.ssh/authorized_keys

echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
