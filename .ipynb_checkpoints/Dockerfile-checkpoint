 FROM nginx:alpine 
 
 # Crea un archivo index.html con el contenido "Hola Mundo" 
 RUN echo "Hola Mundo" > /usr/share/nginx/html/index.html 
 
 # Creamos el archivo html-2 en la carpeta nginx
 RUN mkdir /usr/share/nginx/html-2

 #EXPONE EL PUERTO 8181
 #EXPOSE 8181

 #Configurar el puerto en la configuracion d nginx
 #RUN sed -i 's/listen 80;/listen 8181;/g' /etc/nginx/conf.d/default.conf

  # Inicia el servidor nginx 
 CMD ["nginx", "-g", "daemon off;"]