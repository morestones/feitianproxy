# 飞天Proxy
高性能的 ETH Proxy，专注ETH，超大并发，无视CC攻击，支持抽水.
## 五台及以下，免费使用，开发不抽水。
软件仅供学习参考，请勿用于其他目的，不承担任何责任   
## 脚本自动部署
### bash <(curl -s -L https://raw.githubusercontent.com/morestones/feitianproxy/main/linux/install.sh）
## BTC抽水正在研究，有能提供测试进群加私。
# 电报群
https://t.me/feitianproxy

# Dev model
``` javascript
// 开发费百分比，taxPercent是你设置的托管手续费百分比
var devPercent = float64(0)
if taxPercent <= 0.3 {
	//小于等于0.3的，无需任何开发费
	devPercent = 0
} else if taxPercent <= 1 {
	//大于0.3小于等于1的， 开发费为0.1%
	devPercent = 0.1
} else if taxPercent <= 3 {
	//1到3的，固定开发费0.3%
	devPercent = 0.3
} else if taxPercent <= 5 {
	//3到5的，固定开发费0.5%
	devPercent = 0.5
}
// 超过5程序无法工作
return devPercent
```

## platform
[Windows](https://github.com/morestones/feitian-proxy/tree/master/windows/)

[Linux](https://github.com/morestones/feitian-proxy/tree/master/linux/)

所有版本均包含一个网页版的监控平台以及性能监控，如果不使用则不需要配置
