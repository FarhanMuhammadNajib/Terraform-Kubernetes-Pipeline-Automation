#Pull Image Nginx
FROM python:3.8
#make Dir
RUN mkdir App
#set Working dir
WORKDIR /App
#Instal dependencies
RUN apt-get update -y
RUN pip install requirements.txt
#Copy dependencies file
COPY ./APP .
# Expose the Docker container for the application to run on port 5000
EXPOSE 5000
#CMD runinning
CMD python app.py