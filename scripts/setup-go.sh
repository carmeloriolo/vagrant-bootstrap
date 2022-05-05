#!/usr/bin/env bash

GO_VERSION=$1

install_go() {
  VER=$1
  wget "https://go.dev/dl/go${VER}.linux-amd64.tar.gz" -O go.tar.gz
  tar -zxvf go.tar.gz
  mv go /usr/local/ 
  echo "PATH=$PATH:/usr/local/go/bin" >> /home/vagrant/.profile
  rm -rf go.tar.gz go
}


install_go ${GO_VERSION}
