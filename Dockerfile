# Usar uma imagem base com Python
FROM python:3.10-slim

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copiar apenas os arquivos necessários para evitar cache excessivo
COPY requirements.txt /app/

# Atualizar os pacotes do sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Instalar dependências do Python usando --no-cache-dir para economizar espaço
RUN pip install --upgrade pip --no-cache-dir

# Instalar pacotes do projeto sem privilégios de root
RUN pip install --user --no-cache-dir -r requirements.txt

# Adicionar o binário local do pip ao PATH (devido ao uso de --user)
ENV PATH=/root/.local/bin:$PATH

# Copiar o código-fonte para o container
COPY . /app/

# Expor a porta padrão do Django (opcional, apenas para desenvolvimento)
EXPOSE 8000

# Comando para iniciar o Django (modifique para o que você precisar)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
