#!/bin/bash

# install docker
install_docker_ubuntu() {
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
}

# docker comose install
install_docker_compose_ubuntu() {
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

install_docker_centos() {
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
}

install_docker_compose_centos() {
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    if [ "$OS" = "ubuntu" ]; then
        install_docker_ubuntu
        install_docker_compose_ubuntu
    elif [ "$OS" = "centos" ]; then
        install_docker_centos
        install_docker_compose_centos
    else
        echo "ERR13 현재 버전에서 지원하지 않는 OS 입니다.: $OS"
        exit 1
    fi
else
    echo "운영체제 감지에 실패했습니다."
    exit 1
fi

echo "도커와 도커 컴포즈를 성공적으로 설치했습니다."