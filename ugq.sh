bash -c '
echo -e "本脚本由 [iqsoo.com] 提供 · 云端清理实用工具脚本\n即将开始卸载内置云盾组件，倒数10秒开始..."
for i in {10..1}; do
  echo -n "$i " && sleep 1
done
echo -e "\n开始执行..."

try_exec() {
  local cmd="$1"
  local desc="$2"
  local retry=0
  local max_retry=3
  until timeout 10 bash -c "$cmd"; do
    ((retry++))
    echo "[!] 第 $retry 次重试失败：$desc"
    if [ "$retry" -ge "$max_retry" ]; then
      echo "[x] 跳过：$desc"
      break
    fi
    sleep 1
  done
}

try_exec "wget -q \"http://update2.aegis.aliyun.com/download/uninstall.sh\" -O uninstall.sh" "下载卸载脚本1"
try_exec "chmod +x uninstall.sh && ./uninstall.sh" "执行卸载脚本1"

try_exec "wget -q \"http://update.aegis.aliyun.com/download/uninstall.sh\" -O uninstall.sh" "下载卸载脚本2"
try_exec "chmod +x uninstall.sh && ./uninstall.sh" "执行卸载脚本2"

sudo -i bash -c "
try_exec() {
  local cmd=\"\$1\"
  local desc=\"\$2\"
  local retry=0
  local max_retry=3
  until timeout 10 bash -c \"\$cmd\"; do
    ((retry++))
    echo \"[!] 第 \$retry 次重试失败：\$desc\"
    if [ \"\$retry\" -ge \"\$max_retry\" ]; then
      echo \"[x] 跳过：\$desc\"
      break
    fi
    sleep 1
  done
}

try_exec \"systemctl stop tat_agent\" \"停止 tat_agent\"
try_exec \"systemctl disable tat_agent\" \"禁用 tat_agent\"
try_exec \"/usr/local/qcloud/stargate/admin/uninstall.sh\" \"卸载 Stargate\"
try_exec \"/usr/local/qcloud/YunJing/uninst.sh\" \"卸载 YunJing\"
try_exec \"/usr/local/qcloud/monitor/barad/admin/uninstall.sh\" \"卸载 Barad\"

try_exec \"rm -f /etc/systemd/system/tat_agent.service\" \"删除 tat_agent 服务文件\"
try_exec \"rm -rf /usr/local/qcloud\" \"删除 qcloud\"
try_exec \"rm -rf /usr/local/sa\" \"删除 sa\"
try_exec \"rm -rf /usr/local/agenttools\" \"删除 agenttools\"

process=(sap100 secu-tcs-agent sgagent64 barad_agent agent agentPlugInD pvdriver)
for i in \${process[@]}; do
  for A in \$(ps aux | grep \$i | grep -v grep | awk '{print \$2}'); do
    try_exec \"kill -9 \$A\" \"终止进程 \$i (\$A)\"
  done
done

try_exec \"rm -rf /etc/sgagent\" \"删除 /etc/sgagent\"
try_exec \"rm -rf /var/log/sgagent\" \"删除 /var/log/sgagent\"
try_exec \"rm -rf /usr/local/bin/sgagent\" \"删除 /usr/local/bin/sgagent\"
try_exec \"rm -rf /etc/barad-agent\" \"删除 /etc/barad-agent\"
try_exec \"rm -rf /var/log/barad-agent\" \"删除 /var/log/barad-agent\"

echo -e \"\n卸载任务完成，已清理所有已知云盾组件（含阿里云、腾讯云）\"
"
'
