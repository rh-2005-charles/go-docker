# Usar una imagen oficial de Go como base
FROM golang:1.20

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /go-docker

# Verificar el estado inicial del contenedor
RUN echo "Verificando el entorno..." && \
    go version && \
    ls -l

# Copiar solo el archivo go.mod (sin go.sum por ahora)
COPY go.mod ./

# Verificar si go.mod está presente y qué contiene
RUN echo "Contenido de go.mod:" && \
    cat go.mod && \
    ls -l go.mod

# Ejecutar go mod tidy para verificar si hay dependencias rotas
RUN echo "Ejecutando go mod tidy..." && \
    go mod tidy && \
    echo "go mod tidy completado" || echo "Error en go mod tidy"

# Copiar el resto de los archivos del proyecto
COPY . .

# Verificar los archivos copiados
RUN echo "Archivos copiados en el contenedor:" && \
    ls -l && \
    echo "Contenido de go.mod:" && \
    cat go.mod

# Intentar compilar la aplicación para ver si hay problemas con la compilación
RUN echo "Compilando la aplicación..." && \
    go build -o app . && \
    echo "Compilación completada" || echo "Error en la compilación"

# Comando para ejecutar la aplicación
CMD ["./app"]

