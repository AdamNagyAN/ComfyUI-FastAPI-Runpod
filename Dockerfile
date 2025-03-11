FROM python:3.11-slim
WORKDIR /usr/app/comfyui-rest-api

# Install dependencies
RUN apt-get update && apt install -y git g++ libgl1 libglib2.0-0

# Download and install ComfyUI and its dependencies
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
RUN pip install -r ./ComfyUI/requirements.txt
RUN git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git ComfyUI/custom_nodes/ComfyUI_IPAdapter_plus
RUN git clone https://github.com/Gourieff/ComfyUI-ReActor.git ComfyUI/custom_nodes/ComfyUI-ReActor
RUN pip install -r ./ComfyUI/custom_nodes/ComfyUI-ReActor/requirements.txt

# Install API dependencies
COPY ./requirements.txt .
RUN pip install -r ./requirements.txt

# Copy code at last
COPY ./src ./src
COPY ./test_input.json ./


RUN ls -la && pwd

CMD ["bash", "-c", "python ComfyUI/main.py --cpu & uvicorn src.main:app --host 0.0.0.0 --port 5000 --reload"]