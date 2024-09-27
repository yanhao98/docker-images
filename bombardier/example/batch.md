## 在多个服务端启动Server

```bash
docker run --rm -p 1227:80 nginx
```

## 进行测试

```bash
#!/bin/bash
# 定义一个包含所有 IP 地址的数组
ips=()
ips+=("140.238.16.103")
ips+=("146.56.128.30")

# 循环遍历数组中的每个 IP 地址
for ip in "${ips[@]}"
do
  # 对每个 IP 地址进行压测
  docker run --rm --net=host yanhao98/bombardier --latencies -d 5s --connections 500 "http://$ip:1227/"
  sleep 1
done

set -x
curl -s ip.sb
```
