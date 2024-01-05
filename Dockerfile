# BUILD phase
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# /app/build ←----- all the stuff will be here


# RUN phase
# Con la palabra FROM en en dockerfile, se identifica el inicio
# de un nuevo bloque (una nueva fase)
FROM nginx
# indicamos que queremos copiar de la fase builder, y que carpeta
# queremos copiar, y a dónde copiar (tiene 
# ruta recomendada por docker hub)
COPY --from=builder /app/build /usr/share/nginx/html

# no necesitamos indicar el comando de start (npm run build)  ya que
# es el comando que se ejecuta por defecto en la imagen de nginx