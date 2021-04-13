# Imagem base
FROM python:3.9-slim

# Diretório padrão, equivale ao "mkdir job" e "cd /job" antes de todas as próximas linhas (e do cmd/run)
WORKDIR /job

# ADD ~= COPY
# ADD source dest
ADD requirements.txt .

# RUN equivale a executar o comando abaixo no linux durante o build
RUN pip install -r requirements.txt
## Copy the job folder

# Adiciona todos os arquivos do contexto (.) para o workdir (.)
ADD . .
EXPOSE 80
# Unica linha que não vai "rodar" agora, fica na imagem esperando o docker run (e pode ser sobrescrita)
CMD python main.py