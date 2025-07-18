#!/bin/bash

# 🎨 Fonction d'affichage stylisée
function print_centered_title() {
  local title="🚀 Déploiement de ArgoCD par Nassim 🚀"
  local width=$(tput cols)
  local padding=$(( (width - ${#title}) / 2 ))
  printf "\n%*s\n\n" $((padding + ${#title})) "$title"
}

function countdown() {
  local seconds=$1
  while [ $seconds -gt 0 ]; do
    echo -ne "⏳ Attente : $seconds seconde(s)...\r"
    sleep 1
    ((seconds--))
  done
  echo ""
}

clear
print_centered_title

# Étape 1 : Créer le namespace argocd s’il n'existe pas!
if ! kubectl get namespace argocd &>/dev/null; then
  echo "✅ Création du namespace 'argocd'..."
  kubectl create namespace argocd
  countdown 2
else
  echo "⚠️  Le namespace 'argocd' existe déjà."
fi

# Étape 2 : Appliquer les manifests officiels ArgoCD
echo "📦 Installation d'ArgoCD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
countdown 25

# Étape 3 : Vérification des pods
echo "🔍 Vérification des pods ArgoCD..."
kubectl get pods -n argocd
countdown 5

# Étape 4 : Port-forward pour accéder au dashboard ArgoCD
echo "🌐 Lancement de l'accès local sur http://localhost:8080 ..."
echo "💡 kubectl port-forward svc/argocd-server -n argocd 8080:443"


