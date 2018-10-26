# docker-image-mysql-5.7

---

## 1.0

### 修改`mysql.cnf`配置文件

```shell

[mysql]
...
default-character-set=utf8

```

### 修改`mysqld.cnf`配置文件

```
[mysqld]
...
default-storage-engine=INNODB
character-set-server=utf8
collation-server=utf8_general_ci
```

### 测试

```shell
mysql> SHOW VARIABLES LIKE 'character%';
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | utf8                       |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | utf8                       |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
```

## 1.1 

### 修改`mysqld.cnf`配置文件添加`sql_mode`

```
[mysqld]
...
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
```

### 测试

```
mysql> select @@sql_mode;
+--------------------------------------------+
| @@sql_mode                                 |
+--------------------------------------------+
| STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION |
+--------------------------------------------+
1 row in set (0.00 sec)
```

## 1.2

### 修改默认运行用户`mysql`

修改默认运行用户`mysql`为`1020`.

### 更新旧的用户文件系统

需要依次处理各个节点.

1. 使当前节点离开集群

```
docker exec -it mysql /bin/bash

mysql -uxxx -pxxx -hxxx -Pxxx

## 关闭组复制
STOP GROUP_REPLICATION;

## 检测是否关闭成功
SELECT * FROM performance_schema.replication_group_members;
```

2. 关闭容器

```
docker stop mysql
docker rm mysql
```

3. 更新镜像

```
docker pull registry.cn-hangzhou.aliyuncs.com/marmot/mysql-5.7
```

4. 创建用户

```
sudo groupadd -g 1020 mysql
sudo useradd mysql -u 1020 -g mysql

#检查
id mysql
```

5. 修改文件所属用户和用户组

```
sudo chown -R mysql:mysql /data/mysql
```

6. 启动服务

```
docker run --net=host -v /data/mysql/config/:/etc/mysql/mysql.conf.d/ -v /data/mysql/data/:/var/lib/mysql --add-host=mgr-1:IP1 --add-host=mgr-2:IP2 --add-host=mgr-3:IP3 --name=mysql -e MYSQL_ROOT_PASSWORD=xxxx -d registry.cn-hangzhou.aliyuncs.com/marmot/mysql-5.7
```

7. 添加入集群

```
docker exec -it mysql /bin/bash

mysql -uxxx -pxxx -hxxx -Pxxx

set global group_replication_allow_local_disjoint_gtids_join=ON;
START GROUP_REPLICATION;

## 检测是否关闭成功
SELECT * FROM performance_schema.replication_group_members;
```

8. 在`mysql`的`route`节点如果有需要当所有节点更新完成以后重启`route`

```
sudo systemctl restart mysqlrouter.service
```

## 1.3

添加慢日志, 设定查询超过`2s`都记录下来.

```
[mysqld]
...
slow_query_log_file = /var/lib/mysql/slow.log
slow_query_log = on
long_query_time = 2 
```