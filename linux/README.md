# 飞天Proxy  
## 一、脚本自动部署
### bash <(curl -s -L https://raw.githubusercontent.com/morestones/feitianproxy/main/linux/install.sh）
## 二、手动部署
### 1.安装git
yum install git -y
### 2.下载源码
git clone https://github.com/morestones/feitianproxy.git
### 3.切换到Linux目录
cd feitianproxy/linux/
### 4.授于执行权限
chmod +x feitian-proxy

## 二、配置文件
``` json
{
  "log_enable": false,
  "port": 6666,
  "ssl_enable": true,
  "eth_pool_addr": "eth.f2pool.com:6688",
  "eth_pool_is_ssl": false,
  "tax_percent": 0.5,
  "tax_username": "",
  "tax_worker": "",
  "http_port": 0,
  "http_username":"admin",
  "http_password":"admin"
}
```

| 参数 | 值 | 说明 |
| ----  | ----  | ------- |
| log_enable  | true/false | 是否开启日志，默认不开启 |
| port  | 6666 | 服务监听端口|
| ssl_enable  | true | 是否启用SSL模式，建议开启，需要cert文件夹内的证书文件 |
| eth_pool_addr  | 域名：端口 | 矿池地址，例如：asia1.ethermine.org:4444 |
| eth_pool_is_ssl  | false | 矿池地址是否是SSL，如果是SSL需要设置为true |
| tax_percent  | % | 托管的百分比，0.5表示 0.5%|
| tax_username  | * | 你的ETH钱包地址或者用户名 |
| tax_worker  | *  | 矿工名称前缀，会在矿工名称增加真实矿工名，保证规模应用的稳定性 |
| http_port  | * | 开启网页监控平台，端口为0表示不启用，开启或输入服务器地址:端口即打开查看 |
| username  | * | 监控平台的用户名 |
| password  | * | 监控平台的密码 |


# 运行
``` bash
设置文件执行权限，切换到相关目录， chmod +x feitian-proxy
```

##  直接启动

./feitian-proxy

## supervisor 托管 
``` bash
apt install supervisor -y
cd /etc/supervisor/conf/  #如果找不到这个目录，执行 cd /etc/supervisor/conf.d/
nano feitian-proxy.conf
```

``` bash
[program:feitian-proxy]
command=/your directoryname/feitian-proxy
directory=/your directoryname/
autostart=true
autorestart=true
```

``` bash
supervisorctl reload
```

## screen 启动
``` bash
screen -S feitian-proxy
cd /your directoryname
./feitian-proxy
```


## 注意事项

1.配置文件一定要修改
2.建议启动SSL,关于SSL 如果要用自己的域名证书，请直接替eth.key和eth.crt文件，和可以自己openssl创建后进行替换
3.关于supervisor 或者screen 使用可以自行google

如修改了配置，修改后需要重新执行程序

矿机无法连接请检查防火墙，如果使用云服务商需要检查安全组是否开放端口
