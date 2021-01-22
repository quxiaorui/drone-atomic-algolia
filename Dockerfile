FROM plugins/base:linux-amd64

LABEL maintainer='qxr <quxiaorui@qq.com>'

ENV WORKPATH="/drone/src"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
	&& apk update && apk --no-cache add nodejs npm \
	&& mkdir -p $WORKPATH/algolia \
	&& cd $WORKPATH/algolia \
	&& npm init -y \
	&& npm --registry https://registry.npm.taobao.org install atomic-algolia --save \
	&& rm -rf /var/cache/apk/* \
    	&& rm -rf /root/.cache \
    	&& rm -rf /tmp/*

COPY ./package.json $WORKPATH/algolia/package.json

CMD cd $WORKPATH/algolia&&npm run algolia
