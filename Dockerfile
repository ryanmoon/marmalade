#########################################
# DOCKERFILE FOR NGINX TO USE WITH IMAGR
#########################################

###########################
# LATEST VERSION OF ALPINE
###########################

FROM alpine:3.6

MAINTAINER Ryan Moon (ryan.moon@gmail.com)

###############
# ADD PACKAGES
###############

RUN apk add --update \
    nginx \
  && rm -rf /var/cache/apk/*

###########################
# CREATE DIRECTORIES & LOG
###########################

RUN mkdir /images && \
  touch /var/log/nginx/access.log && \
  touch /var/log/nginx/error.log


######################
# ADD FILES & SCRIPTS
######################

ADD nginx.conf /etc/nginx/nginx.conf
ADD start.sh /start.sh

#####################
# CORRECT PERMISIONS
#####################

RUN chown -R root:root /etc/nginx/nginx.conf && \
	chown -R root:root /start.sh && \
	chmod +x /start.sh && \
  chown -R nginx:www-data /var/lib/nginx

###############
# DISPLAY LOGS
###############

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

###############
# EXPOSE PORT
###############

EXPOSE 8080

########
# START
########

CMD ["/start.sh"]

