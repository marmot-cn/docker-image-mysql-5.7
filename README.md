# docker-image-mysql-5.6

---

## 1.1

修改`my.cnf`配置文件:

```shell

[client]
...
default-character-set=utf8

[mysqld]
...
explicit_defaults_for_timestamp
default-storage-engine=INNODB
character-set-server=utf8
collation-server=utf8_general_ci
```

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
```# docker-image-mysql-5.7
