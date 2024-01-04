# Local Kubernetes Cluster Setup

## Install Docker
```bash
apt install docker.io
docker version
```
![image](https://user-images.githubusercontent.com/76629897/204837565-7a1fd49e-d3a0-4f55-ae1a-333932179c2b.png)

## Install Go Binary
```bash
apt install golang-go
go version
```
![image](https://user-images.githubusercontent.com/76629897/204838545-6fe407a6-3724-4420-ab49-a992ed890da6.png)


## Install Kind
```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/local/bin
kind version
```

![image](https://user-images.githubusercontent.com/76629897/204838666-d8020b3c-a369-4212-a491-2d2e21259d95.png)


## Install Kubectl
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
mv kubectl /us/local/bin
kubectl version
```
![image](https://user-images.githubusercontent.com/76629897/204838990-c8e4320b-0316-4a82-981c-1d8e70e7317c.png)

# Create a Cluster
```bash
kind create cluster --name <cluster-name>
```
![image](https://user-images.githubusercontent.com/76629897/204839805-bb132f67-638f-4971-a19d-9e4fe8f0e89e.png)

Now Validate the cluster
```bash
kubectl cluster-info --context kind-<cluster-name>
```
![image](https://user-images.githubusercontent.com/76629897/204840324-b73761fc-e5a2-4bf6-8c74-ed52f65b83f1.png)

If you want to have the cluster exposed externally then use this yaml code.
```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: <cluster-name>
networking:
  # WARNING: It is _strongly_ recommended that you keep this the default
  # (127.0.0.1) for security reasons. However, it is possible to change this.
  apiServerAddress: "<PUBLIC-IP5"
  # By default the API server >istens on a random open port.
  # You may choose a specific port but probably don't need to in most cases.
  # Using a random port makes it easier to spin up multiple clusters.
  apiServerPort: 443
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
```
Now you create cluster with command below
```bash
kind create cluster --config <filename>.yml
```
