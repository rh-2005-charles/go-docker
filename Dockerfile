# Usar una imagen oficial de Go como base
FROM golang:1.20

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /go-docker

ENV GO111MODULE=on
# Copiar solo los archivos de Go necesarios para las dependencias
COPY go.mod go.sum ./

# Descargar las dependencias
RUN go mod tidy

# Copiar el resto de los archivos del proyecto al contenedor
COPY . .

# Compilar el binario de la aplicación
RUN go build -o app .

# Comando para ejecutar la aplicación
CMD ["./app"]

