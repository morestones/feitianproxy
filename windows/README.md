# 飞天Proxy  

## 下载

目录里的文件都要下载

## 配置文件
编辑config.json文件，注意//之后的都删掉，包括//
``` json
{
  "log_enable": false,
  "port": 6666,
  "ssl_enable": true,
  "eth_pool_addr": "",
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

##  方式一

直接双击feitian-proxy.exe ，每次重新启动系统需要重新再次运行

## 方式二  

执行 CMD命令， 起到对应的目录里面输入
feitian-proxy.exe install 
提示操作成功后，可以到服务(services.msc)里面启动Feitian Proxy 或者 重启系统即可自动启动
如需要卸载服务可以执行
feitian-proxy.exe uninstall 

## 注意事项

1.配置文件一定要修改
2.建议启动SSL,关于SSL 如果要用自己的域名证书，请直接替cert文件夹下的eth.key和eth.crt文件，和可以自己openssl创建后进行替换

如修改了配置，修改后需要重新执行程序，或者去services.msc里重启Feitian Proxy服务

矿机无法连接请检查防火墙，如果使用云服务商需要检查安全组是否开放端口