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