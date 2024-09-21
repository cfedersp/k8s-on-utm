DISCOVERY_TOKEN=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt     | openssl rsa -pubin -outform der 2>/dev/null     | openssl dgst -sha256 -hex     | sed 's/^.* //')

JOINTOKEN=$(kubeadm token list | grep -v TOKEN | head -1 | cut -d ' ' -f1)

APISERVER_ENDPOINT=$(kubectl get pod kube-apiserver-master   -n kube-system -o json | jq -r '.metadata.annotations["kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint"]')

jo nodeRegistration=$(jo name="master" criSocket="unix:///var/run/crio/crio.sock") discovery=$(jo bootstrapToken=apiServerEntpoint=$APISERVER_ENDPOINT token=$JOINTOKEN caCertHashes=$(jo -a "sha256:$DISCOVERY_TOKEN") unsafeSkipCAVerification=true) | yq -rRy > join-cluster.yaml

kubeadm join --config join-cluster.yaml

