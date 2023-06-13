#Pull Image Nginx
FROM python:3.8
#make Dir
RUN mkdir App
#set Working dir
WORKDIR /App
ENV DEBIAN_FRONTEND noninteractive
#Copy dependencies file
COPY ./APP .
#Instal dependencies
RUN apt-get update -y
RUN apt install libgl1-mesa-glx -y
RUN apt-get install 'ffmpeg'\
    'libsm6'\
    'libxext6'  -y
RUN pip3 install --upgrade pip
RUN pip3 install opencv-python==4.3.0.38
RUN pip install tensorflow && pip install flask && pip install Pillow && pip install pybase64 && pip install Python-IO && pip install matplotlib
# Expose the Docker container for the application to run on port 5000
EXPOSE 5000
#CMD runinning
CMD python app.py