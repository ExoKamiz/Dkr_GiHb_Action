# Budowanie aplikacji w oparciu o obraz node
FROM node:14 as builder

# Ustalenie katalogu roboczego
WORKDIR /app

# Skopiowanie plików package.json i package-lock.json
COPY package*.json ./

# Instalacja zależności
RUN npm install

# Skopiowanie plików źródłowych aplikacji
COPY . .

# Budowanie aplikacji
RUN npm run build

# Produkcja obrazu
FROM nginx:latest

# Kopiowanie wynikowych plików z poprzedniego etapu
COPY --from=builder /app/build /usr/share/nginx/html

# Ustawienia Nginx
EXPOSE 80

# Uruchomienie Nginx w tle
CMD ["nginx", "-g", "daemon off;"]
