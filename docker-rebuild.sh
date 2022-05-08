#!/bin/bash
# --------------------------------------------------------------------
#
# 该脚本主要用于容器的删除，镜像的删除，根据 Dockerfile 构建镜像
# 每次修改 Dockerfile 后都需要删容器，删镜像，重新构建，比较麻烦
#
# --------------------------------------------------------------------
image=$1
path=$(pwd)

if test $image -z
then
    echo "param [ image ] is empty"
    exit 0
fi

dockerfile=$2
if test $docker-file -z
then
    echo "param [ docker-file ] is empty"
    exit 0
fi

docker ps -a | grep $image | awk '{print $1}' | xargs docker rm -f
echo ">>> container deleted"

docker images | grep $image | awk '{print $3}' | xargs docker rmi
echo ">>> image deleted"

docker build -f $path/$dockerfile -t $image .
echo ">>> image rebuild"
