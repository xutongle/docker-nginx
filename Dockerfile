FROM debian:jessie

MAINTAINER XUTONGLE <xutongle@gmail.com>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62 \
    && echo "deb http://www.nginx.org/packages/debian/ jessie nginx" > /etc/apt/sources.list.d/nginx.list \
	&& apt-get update && apt-get install -y nginx --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Add configuration files
COPY image-files/ /

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx"]
