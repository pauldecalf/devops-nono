FROM node:20-alpine

# Dépendances système utiles (optionnel mais recommandé)
RUN apk add --no-cache bash

# Crée le dossier de travail
WORKDIR /usr/src/app

# Copie les fichiers de lock/package pour installer les dépendances
COPY package.json pnpm-lock.yaml ./

# Installe PNPM
RUN npm install -g pnpm

# Installe les dépendances
RUN pnpm install

# Copie le reste des fichiers
COPY . .

# Assure que le dossier dist existe
RUN mkdir -p dist

# Build l'application (le code source est déjà présent maintenant)
RUN pnpm run build

# Expose le port
EXPOSE 3000

# Lancement de l'application en production
CMD ["pnpm", "run", "start"]
