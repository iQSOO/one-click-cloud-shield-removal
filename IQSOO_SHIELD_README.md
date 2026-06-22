# iQSOO 隐私网络

这是一个独立品牌的 Android 隐私网络客户端构建分支。它基于 GPL-3.0-or-later 的 sing-box 与官方 Android 客户端源码构建，不使用原应用名称，也不声称与上游官方有关联。

## 核心能力

- Android `VpnService` 全局 TUN、系统代理与本地代理模式
- VLESS、VMess、Trojan、Shadowsocks、SOCKS、HTTP、Hysteria 2、TUIC、WireGuard、SSH、Tor、NaiveProxy、Tailscale 等 sing-box 当前构建支持的协议/端点
- TCP/UDP、IPv4/IPv6、分应用代理、规则集、域名/IP/端口/进程路由、策略组、URL 测速
- DNS 分流、DoH/DoT/DoQ、FakeIP、DNS 劫持与缓存
- 订阅/远程配置、本地 JSON、二维码、文件导入、连接与日志面板
- 快捷设置磁贴、开机恢复、远程 sing-box 控制、Tailscale/SSH/USB-IP 工具

最终可用功能取决于所导入配置、服务端能力、Android 版本和 sing-box 对应稳定版本。

## 隐私默认值

- 不集成广告、统计 SDK 或第三方崩溃上报 SDK
- 更新轮询默认关闭
- 自动更新默认关闭
- VPN 绕过默认关闭
- Android 云备份关闭
- 配置、订阅与日志保存在本机应用沙箱

客户端无法替代可信服务端。节点运营者、DNS 上游和目标网站仍可能观察相应元数据；应用不会宣称“绝对匿名”。

## 可复现构建

GitHub Actions 固定拉取 `SagerNet/sing-box` 的 `v1.13.13` 标签及其 Android 子模块，构建 libbox，应用独立品牌和隐私补丁，再输出：

- 按 ABI 拆分的 APK
- universal APK
- SHA-256 校验值
- 对应的完整源码快照

构建使用临时独立签名。正式长期发布时应改为由所有者保管的固定离线签名密钥，否则后续版本无法覆盖安装。

## 许可证与归属

上游项目版权归各自作者所有。本分支及生成的衍生版本遵循 GPL-3.0-or-later。不得使用上游原应用名称或暗示官方关联。