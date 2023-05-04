#Pull Image Nginx
FROM python:3.8
#make Dir
RUN mkdir App
#set Working dir
WORKDIR /App
#Instal dependencies
RUN apt-get update -y
RUN pip install tensorflow && pip install joblib && pip install flask && pip install Pillow
#Copy dependencies file
COPY ./APP .
#Running Prerequisite
RUN python BuildModel.py
#CMD runinning
CMD python app.py