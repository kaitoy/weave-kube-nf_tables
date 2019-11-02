# weave-kube with nftables

[weave-kube](https://hub.docker.com/r/weaveworks/weave-kube) container image that uses nftables rather than iptables.
This is created to solve [the issue "Weave Net breaks when host OS uses iptables 1.8"](https://github.com/weaveworks/weave/issues/3465) without changing host OS to use iptables in legacy mode.
