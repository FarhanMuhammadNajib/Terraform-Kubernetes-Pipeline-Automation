#Pull Image Nginx
FROM nginx:latest
#set Working dir
WORKDIR /usr/share/nginx
#Instal dependencies
RUN apt-get update -y
RUN apt-get install git -y
#Clone Repo
RUN git clone https://github.com/faahim/happy-birthday.git
#Change Content App
RUN mv html html2
RUN mv happy-birthday html