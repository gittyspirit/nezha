FROM ghcr.io/naiba/nezha-dashboard

EXPOSE 80

WORKDIR /dashboard

COPY entrypoint.sh /dashboard/
COPY sqlite.db /dashboard/data/
COPY resource/template/theme-custom/* /dashboard/resource/template/theme-custom/
COPY resource/static/theme-custom/* /dashboard/resource/static/theme-custom/

RUN apt-get update &&\
    apt-get -y install openssh-server wget iproute2 vim git cron unzip supervisor systemctl &&\
    chmod +x entrypoint.sh &&\
    git config --global core.bigFileThreshold 1k &&\
    git config --global core.compression 0 &&\
    git config --global advice.detachedHead false &&\
    git config --global pack.threads 1 &&\
    git config --global pack.windowMemory 50m &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["./entrypoint.sh"]
