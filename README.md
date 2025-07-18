# 🚀 Kafka + ArgoCD + GitOps

Ce projet met en œuvre une architecture **GitOps** complète pour déployer **Apache Kafka** dans un cluster **Kubernetes**, en utilisant **ArgoCD** comme outil de livraison continue. Il intègre également des solutions d’observabilité et de gestion comme **Prometheus**, **Grafana**, **EFK** et **AKHQ**.

---
## 📁 Structure du projet
```bash
kafka-argoCD/
├── akhq/ # Interface de gestion Kafka
├── applications/ # Déclarations ArgoCD (Application CRD)
├── efk/ # Stack de logs (Elasticsearch, Fluentd, Kibana)
├── monitoring/ # Prometheus Operator
├── strimzi/ # Kafka Operator (Strimzi) + manifests CRD kafka
├── script-argocd.sh # Script d'installation ArgoCD
└── README.md
```

## 🔧 Étapes de déploiement

### 1. Déployer ArgoCD dans le cluster
Lance le script suivant pour installer ArgoCD : ./script-argocd.sh

### 2. Récupérer le mot de passe initial d’ArgoCD
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo 
```
### 3. Se connecter à l’interface ArgoCD
```bash
argocd login localhost:8080 --insecure

```
### 4. add repo to argocd 
```bash
argocd repo add <repo-url> \
  --username <votre-username> \
  --password <votre-token>

``` 
### 5. Appliquer les fichiers Application d’ArgoCD
```bash
 kubectl apply -f applications/*.yaml
 ```


