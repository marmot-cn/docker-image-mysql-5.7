FROM mysql:5.7.38
COPY ./my.cnf   /etc/
COPY ./mysql.cnf /etc/mysql/conf.d/
COPY ./mysqld.cnf /etc/mysql/mysql.conf.d/

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone
