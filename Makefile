.PHONY: cluster delete-cluster 

cluster:
        @echo "\n🔧 Creating Kubernetes cluster..."
        kind create cluster --config kind/kind.cluster.yaml

delete-cluster:
        @echo "\n♻️  Deleting Kubernetes cluster..."
        kind delete cluster


