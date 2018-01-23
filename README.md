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
