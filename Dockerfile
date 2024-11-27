# Usar uma imagem base oficial do Python
FROM python:3.9-slim

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar o arquivo requirements.txt para o container
# ADICIONADO: Certifique-se de que o arquivo requirements.txt exista na raiz do projeto local antes de buildar.
COPY requirements.txt /app/requirements.txt

# Instalar dependências listadas em requirements.txt
# ADICIONADO: Validar a existência do arquivo antes de executar.
RUN if [ -f "requirements.txt" ]; then \
        pip install --no-cache-dir -r requirements.txt; \
    else \
        echo "Error: requirements.txt not found. Aborting build."; \
        exit 1; \
    fi

# Atualizar o pip para a versão mais recente (opcional, mas recomendado)
RUN pip install --upgrade pip

# Copiar o restante do código do projeto para o container
COPY . /app

# Comando padrão para rodar o container
CMD ["python", "app.py"]  # Substitua "app.py" pelo arquivo principal do seu projeto
