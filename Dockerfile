 FROM nginx:alpine 
 
 # Crea un archivo index.html con el contenido "Hola Mundo" 
 RUN echo "Hola Mundo" > /usr/share/nginx/html/index.html 
 
 # Inicia el servidor nginx 
 CMD ["nginx", "-g", "daemon off;"]