ARG NODE_VERSION=20.11.0

FROM node:${NODE_VERSION}

ENV PORT=3001
ENV MESSAGE="Hello Docker"

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

RUN useradd -m mynode
USER mynode

RUN chown -R mynode /app

# Verificar o healthcheck da aplicação docker
HEALTHCHECK --interval=10s --timeout=5s --start_period=5s --retries=3 \
    CMD ["curl", "-f", "http://localhost:${PORT}"]

VOLUME ['/data']

EXPOSE 3001

CMD ["node", "index.js"]