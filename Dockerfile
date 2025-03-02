FROM python:3.13-slim

WORKDIR /app
COPY . .

RUN apt-get update -y && apt-get install -y apt-utils curl unzip git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd -m user

USER user
ENV PATH="/home/user/.local/bin:${PATH}"

# Install AgentChat and OpenAI client from Extensions
RUN pip install --upgrade pip && \
    pip install -U "autogen-agentchat" "autogen-ext[openai]" "autogenstudio"

EXPOSE 8080

CMD ["autogenstudio", "ui", "--host", "0.0.0.0", "--port", "8080"]