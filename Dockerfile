FROM node:22.12.0-slim

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm clean-install
COPY . .

CMD ["npm", "run", "watch"]
