 FROM nginx:alpine 
 
 # Crea un archivo index.html con el contenido "Hola Mundo" 
 RUN echo "Hola Mundo" > /usr/share/nginx/html/index.html 
 
 # Inicia el servidor nginx 
 CMD ["nginx", "-g", "daemon off;"]

# Creamos el archivo html-2 en la carpeta nginx
 RUN mkdir /usr/share/nginx/html-2