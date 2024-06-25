FROM tensorflow/tensorflow:2.14.0-gpu

# Set the working directory in the container
WORKDIR /app/

# Mettre à jour les packages et installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libleptonica-dev \
    libtesseract-dev \
    pkg-config \
    poppler-utils \
    && apt-get clean

# Vérifiez que tesseract est installé correctement
RUN which tesseract
RUN tesseract --version

# Ajoutez tesseract au PATH
#ENV TESSERACT_PATH="/usr/bin/tesseract"
#ENV PATH="${TESSERACT_PATH}:${PATH}"


# Add requirements.txt and install packages
ADD requirements.txt /app/
RUN pip install -r requirements.txt

# Add the rest of your application code
ADD . /app/

RUN apt update
RUN apt install -y git

# Install JupyterLab and other dependencies
RUN pip install jupyterlab transformers[torch] accelerate
RUN pip install jupyter_contrib_nbextensions 
RUN pip install --upgrade notebook==6.4.12
RUN pip install ipywidgets

RUN jupyter contrib nbextension install --user
RUN jupyter contrib nbextension install --user

# Expose ports for the FastAPI app and JupyterLab
EXPOSE 8000
EXPOSE 8888

# Command to run FastAPI app and JupyterLab
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port 8000 & jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''"]
