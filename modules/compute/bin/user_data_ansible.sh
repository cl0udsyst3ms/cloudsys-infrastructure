#!/bin/bash

logger "Install ansible"

add-apt-repository -y ppa:ansible/ansible
apt update 
apt-get install -y ansible

cp /etc/ansible/hosts /etc/ansible/hosts.orig

cat > /etc/ansible/hosts <<EOF
[web]
${node_ip}
EOF

logger "Developer user setup"
useradd -m -d /home/developer -s /bin/bash -c "Dev user" -U developer
mkdir -p /home/developer/.ssh
chown developer:developer /home/developer/.ssh
cat /home/developer/.ssh/id_rsa <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEArSvmtgw0XFaUROgE4dlfd2UzaJbmxsovl2jmzG+heYAyNB+S
GryPcR91hBjC69MiK/T0XHA7Fkbmz1e52+6uh/WoMo+eVpm3KPfhEZpCjFxuuYbg
Gn/vZ7ytcqJiL0CqqP2xl99ITqwe8RjSy5zSDvdvesO4/oQTF9SQjPA6aGu09hiP
3vGYUgixOTsg530XC0pDNzQcdkj/sD7Iky/P+KSQ1NG9CT/XSVm1Jb1egdYqb7JX
X8rvlEWsG5bT+Yot4UaG8RKA9dI0D9SUpZA6KyWBNey8P02BtM+UKuZXlxjCPt/8
ci+isVslJ4zLCQVlPlYgGloPfzxcvt2ODJkuuQIDAQABAoIBAH1Nf+IIULbj2uNF
M4ssW5yr+JfcYN5EnE0llaMlvySIc0st8O0xtWU4SzMrK5eyLU67LznX55lF8mrj
YlPWkClGws7bBspI7bRSMGQpR7ACjgfmpS/nlJZuet6wyvTACPzAnQl0ggCTIMx5
lsXIEmLL/blJ+AkKDjq3D2U7yjeVTyTzIz7qDAzbMERHVq0He7WNOGA48dKXR44j
FJgDL2yzjBsAe18cn9xo/HoxbOuhQ5QooQphcEMmXujfmayVdLu8XsqpNydA0va2
YXs75yXLEYB2z1zkkZ0tOlhZwj2Si/h5kkioHO3MWVBJZ1N2AoN1Gf2gLjtsVbIL
qGjqaVUCgYEA08mgOdmGSA47kK0MSZj/OJZkLcKiPVL+6pCxlmHCKi7N4nmU1FXO
kmlqYJGmOk3uaz4Qf9GQBFz4Kx0EuD6Xtmiw3FH6y0FuMJhQ2hM3CUZKUNOJLGls
1iy5dPpeR6cbOSGNHWrCW9aEg/YmMjqY1t2hsUBa1a7CrqRmhO0R54sCgYEA0VKM
mcsFxjSSKiH52D0R7EVl7isd4rmU7QVztiAW9PfYJ+kOt8LCBOyrsDoezRv2Titq
3lYDc5713XaTWNWX23tSMv3YoT9UrOT1/y1ibPmYjIWxb3qOyfrweF/Q47uvmGA3
6aK/vYjufBzrqloflc2yPSOAWiibfW3LKEIiK0sCgYEAuTe1I8KkGDIyT6W3gEoI
spF8DTURtDX4cGWYmd7m8wM51Z3k1gow/YSpnsjiKk1rfGir/0zj+ZzhALuBHCzJ
e6J1QkmD3uxbFK6wzvdNA5Rwe910Mt4EbA5zJuWrPFjdiwpXomlyjuS9wbas0vLC
Je9wcFbK2ePbqOZoLkoyhV8CgYBmSVltebkrntrh/dJSKZ2NgGgL10P2W8t7e1OM
5udw83/MGOXZRDF9KI3JQs10Wzqj/jFtzkhHgqEQhHYCTfW0CfIj+smWGhVtm0De
XjYfnGRAHsCTAieuaZKCsAeqkTeAVVxdLetWWgh328YJa5rNoEN9/tAkvn0k8Lb6
yD5cOwKBgQCsQnzwIk1PM9sZQRrNv/0NaCwGvdyBqXID/+73EOxJw7BVD6NWXouz
7k8+U8xCC+8JaHIexnOx+7Cfalv4j2UuWQHXfJPzmqOoImaYnYbntiDyykAAGqiH
OuR9bdXhUH8UWjOtcRQB8Dwu3qdycAbNBrHaIfBdnAtHjtB/s5OCOg==
-----END RSA PRIVATE KEY-----
EOF

chmod 400 /home/developer/.ssh/id_rsa
