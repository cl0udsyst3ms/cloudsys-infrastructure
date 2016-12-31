#!/bin/bash

logger "Install ansible"

add-apt-repository -y ppa:ansible/ansible
apt update 
apt-get install -y ansible

cp /etc/ansible/hosts /etc/ansible/hosts.orig
cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.orig
# ansible all -s -m apt -a 'pkg=nginx state=installed update_cache=true'
# ansible all -m ping -s
cat > /etc/ansible/ansible.cfg <<EOF
[defaults]
remote_user = developer
[privilege_escalation]
[paramiko_connection]
[ssh_connection]
[accelerate]
[selinux]
[colors]
EOF
cat > /etc/ansible/hosts <<EOF
[web]
${node_ip}
EOF

logger "Developer user setup"
useradd -m -d /home/developer -s /bin/bash -c "Dev user" -U developer
mkdir -p /home/developer/.ssh
chown developer:developer /home/developer/.ssh
touch /home/developer/.ssh/id_rsa
cat /home/developer/.ssh/id_rsa <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAq41gAXPTHav63wuzbSEZOtTiJx8uhhbadEO1IiIXs1i5132a
0Wlwzf+KeQo5IQCGDi9sCTfLMSz0rhg5bNS1O0Lqyf5lvmfcs3u7fc/OlPVX8QEU
OkJ/dmEKHtSzcX3MK+aMYYZWUQfLDEaJzUbSlBC2OYevrdfPiY26TYqMnZqfuhUu
CL0Lu0HDYf14yRfpSHyvrP5GBFEdUSYm1SCYaGEbgte1U/9AolerBFDhlLAQc7RT
wyBj64iSne7hkbYVqTVIFaGrLeLGF1UZchP/G17z0lhTRx66oBckQNYburL+94Y8
GFuaBBqVb+Nf8SWjVkuE5xAoVpe7yZ52DG72AQIDAQABAoIBAApmXqyX3fONin7d
EbqK6CGl6DPg8wwT9JhZxnBUSsWHmnSS28DYOIt0c2uVEBONGZNgkpcYd8v6Yrbv
JwQO/RGjo+Is9vQNDdcfqCUfZPGo0fT9UMGbaGi/x0JJOLunmaoLpvT+lNsCsu+C
kzYLlhZ90N45+I98Zst6+RFcVdvz+03xsGa/iKn35bR3JXGUim+nWMGXfNjacPg4
FEFO8vorl6Vb21Jxfjg4H2DWSYEhOPEXdoDNJQjdkUjLajAtUFS9JjN76JrLYdVz
j7SOf0IjrYmHvsblkfHhpbOmt6uJ8E70pq3HtI+7PPI2avuDTuN/t7gcxmoAQN8W
2BogYiUCgYEA2vgB4ssamRaiyGM9Spuu3R5v/x6R+6wfMBaj4M6NMTZ1ogDEukX5
HmP2hkYLiQNirqAvz7/nDG7jjgEoPD1o3ei4YkoP4xELcJmMLfHcgTMuQLskRndT
bDijaETSCjawptPlUbXUCt3gttMD3+ATQ/ABfZfmXcnzLRZhlMCe4PsCgYEAyJCG
ezdz9rPKn7tcgWFpC+TcRcqnadTLKhO3Rd8xYRDkdowX9nXnrYGQJHz0lkT25+Ul
kI91BOFyTE4eyz5MBnSuc7Rdpeq2LIV919cw3fA/q1hULuu8j5VKptSef43UFwCU
HdcySi0BMAeNyMD13dVV/9iBtgJSijtoO4HHLDMCgYBS0gNEmLWSubEQQhjoo0Hc
eKq7wABPRKb3NVj+qqFUv9h2UfwWyGiVShHwb4XlaNZmXkg3N8pYNYj0KRPi1QdZ
B7DV3FVt+QBusmUG67gPViBkc2QhEvkGsdV8lqsrGcxvDS5rXW66PXnFLMMGZmZj
B+BIdK+5Qa0snI6ECOcPCQKBgF3EtBsHYgAFLsZfInCayjH1XcaDaKHiCtoxPY49
OyjWbPm/pbRki1xjJrDoerGGrKjeSSG88EjH3lgubdc32PNrueP+f4oCoglOn/c5
dG9O03WYZkNJk27NrYkx/qhD9tSKQLVy1uA3CkcaQP+Kt2hvRTXIU1x02YInJCQu
GKBhAoGBAIFsMKz7NJar4/fSZi4j2Kb+wwIv33tqSk35lvrgsu8jQl0voeHM0Mhv
2506GyhHpUz8JOlHQxsEr5JzEaBK9co+Za5HODRxijyB1r5yUB3FICyUVYqNtzPo
JsFIlO9q8eE0Oe3bNuIAoZwqY48/zeX+hoL88kX+nSJvQoRblrI5
-----END RSA PRIVATE KEY-----
EOF

chmod 400 /home/developer/.ssh/id_rsa
chown developer:developer /home/developer/.ssh/id_rsa
