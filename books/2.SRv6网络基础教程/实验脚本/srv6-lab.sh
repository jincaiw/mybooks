#!/usr/bin/env bash
set -euo pipefail

NAMES=(ce1 pe1 r1 r2 pe2 ce2)

cleanup() {
  for ns in "${NAMES[@]}"; do
    ip netns del "$ns" 2>/dev/null || true
  done
}

if [[ "${1:-}" == "destroy" ]]; then
  cleanup
  exit 0
fi

cleanup
for ns in "${NAMES[@]}"; do ip netns add "$ns"; done

link() {
  local a=$1 ai=$2 b=$3 bi=$4
  ip link add "$ai" type veth peer name "$bi"
  ip link set "$ai" netns "$a"
  ip link set "$bi" netns "$b"
  ip -n "$a" link set "$ai" up
  ip -n "$b" link set "$bi" up
}

link ce1 c1 pe1 p1c
link pe1 p1r r1 r1p
link r1 r1r r2 r2r
link r2 r2p pe2 p2r
link pe2 p2c ce2 c2

for ns in "${NAMES[@]}"; do
  ip -n "$ns" link set lo up
  ip netns exec "$ns" sysctl -qw net.ipv6.conf.all.forwarding=1
  ip netns exec "$ns" sh -c \
    'for f in /proc/sys/net/ipv6/conf/*/seg6_enabled; do echo 1 > "$f"; done'
done

ip -n ce1 addr add 2001:db8:10::2/64 dev c1
ip -n pe1 addr add 2001:db8:10::1/64 dev p1c
ip -n pe1 addr add 2001:db8:11::1/64 dev p1r
ip -n r1  addr add 2001:db8:11::2/64 dev r1p
ip -n r1  addr add 2001:db8:12::1/64 dev r1r
ip -n r2  addr add 2001:db8:12::2/64 dev r2r
ip -n r2  addr add 2001:db8:13::1/64 dev r2p
ip -n pe2 addr add 2001:db8:13::2/64 dev p2r
ip -n pe2 addr add 2001:db8:20::1/64 dev p2c
ip -n ce2 addr add 2001:db8:20::2/64 dev c2

ip -n ce1 -6 route add default via 2001:db8:10::1
ip -n ce2 -6 route add default via 2001:db8:20::1

# Underlay：到下一个 Locator/SID 的路由
ip -n pe1 -6 route add 2001:db8:100::/64 via 2001:db8:11::2
ip -n r1  -6 route add 2001:db8:200::/64 via 2001:db8:12::2
ip -n r2  -6 route add 2001:db8:400::/64 via 2001:db8:13::2

# 回程普通 IPv6
ip -n pe2 -6 route add 2001:db8:10::/64 via 2001:db8:13::1
ip -n r2  -6 route add 2001:db8:10::/64 via 2001:db8:12::1
ip -n r1  -6 route add 2001:db8:10::/64 via 2001:db8:11::1

# Local SID
ip -n r1 -6 route add 2001:db8:100::1/128 \
  encap seg6local action End count dev lo
ip -n r2 -6 route add 2001:db8:200::1/128 \
  encap seg6local action End count dev lo
ip -n pe2 -6 route add 2001:db8:400::100/128 \
  encap seg6local action End.DX6 \
  nh6 2001:db8:20::2 count dev p2c

# Headend：CE2 前缀使用三段 SRv6 封装
ip -n pe1 -6 route add 2001:db8:20::/64 \
  encap seg6 mode encap \
  segs 2001:db8:100::1,2001:db8:200::1,2001:db8:400::100 \
  via 2001:db8:11::2 dev p1r

echo "实验已建立。测试："
echo "  ip netns exec ce1 ping -c 3 2001:db8:20::2"
echo "抓包："
echo "  ip netns exec r1 tcpdump -ni r1p -vv ip6"
echo "清理：$0 destroy"
