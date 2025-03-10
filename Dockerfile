FROM python:3.11-slim
WORKDIR /usr/app/comfyui-rest-api

# Install dependencies
RUN apt-get update && apt install -y git

# Download and install ComfyUI and its dependencies
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
RUN pip install -r ./ComfyUI/requirements.txt

# Install API dependencies
COPY ./requirements.txt .
RUN pip install -r ./requirements.txt

# Copy code at last
COPY ./src ./src

RUN ls -la && pwd

CMD ["bash", "-c", "python ComfyUI/main.py & uvicorn src.main:app --host 0.0.0.0 --port 5000 --reload"]