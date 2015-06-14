#
# Build: docker build -t apt-cacher-ng .
# Run: docker run -it -p 3142:3142 --name apt-cacher-run apt-cacher-ng
# Volume: docker run -it -p 3142:3142 -v /var/data/apt-cache:/var/cache/apt-cacher-ng --name apt-cacher-volume apt-cacher-ng

#
# and then you can run containers with:
#   docker run -t -i --rm -e http_proxy http://dockerhost:3142/ debian bash
#

FROM        ubuntu:14.04
MAINTAINER  liuhong1.happy@163.com
VOLUME      ["/var/cache/apt-cacher-ng"]
RUN echo "deb http://mirrors.aliyun.com/ubuntu trusty main restricted" > /etc/apt/sources.list && echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted" >> /etc/apt/sources.list && echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted" >> /etc/apt/sources.list && echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted" >> /etc/apt/sources.list && echo "deb http://mirrors.aliyun.com/ubuntu/ trusty universe" >> /etc/apt/sources.list && echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty universe" >> /etc/apt/sources.list && echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-updates universe" >> /etc/apt/sources.list && echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates universe" >> /etc/apt/sources.list && echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted" >> /etc/apt/sources.list && echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted" >> /etc/apt/sources.list && echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-security universe" >> /etc/apt/sources.list && echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y apt-cacher-ng
EXPOSE      3142
CMD     chmod 777 /var/cache/apt-cacher-ng && /etc/init.d/apt-cacher-ng start && tail -f /var/log/apt-cacher-ng/*
