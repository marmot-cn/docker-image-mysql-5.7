# docker-image-mysql-5.7

---

## 修改配置文件, 针对单机版高配置服务器

修改`mysqld`参数如下:

```
max_allowed_packet=32M
max_connections=500
innodb_log_file_size=256M
innodb_file_per_table=1
innodb_buffer_pool_size=8G
``