# Treinamento Docker
Repositório de exemplo/documentação de um treinamento informal sobre o Docker

# D1 - Docker

- Isolamento a nível de processos do SO
- Não isola tanto quanto uma VM, mas é muito mais leve (rápido)
- Ambiente independente, "sandbox" (com ressalvas de segurança)
- Imagens são definidas por nome:tag dentro de um registry (ex. [python](https://hub.docker.com/_/python) e [postgres](https://hub.docker.com/_/postgres))
- [Imagens são conjuntos de camadas](https://medium.com/@jessgreb01/digging-into-docker-layers-c22f948ed612)

# D2 - Build

- Cada linha no Dockerfile é uma nova camada
- Dica: camadas que mudam menos tem que ficar no inicio do arquivo, evitando rebuild completo toda hora

```shell script
docker build -t abc:tag . # -t é a tag, '.' é o contexto. -f se o nome do arquivo não for Dockerfile 
docker run --rm abc # --rm para remover containers depois da execução
docker run --rm abc ls # ultimo parametro sobrescreve o CMD no Dockerfile
``` 

# D3 - Run
- `docker run [IMAGEM] [CMD]`, onde o `CMD` default é o definido no Dockerfile  
- Instanciação da imagem, formando um container
- `--rm` para remover o container assim que a execução terminar
- `-it` para "iterativo" e "tty" (terminal), permitindo a interação com o [ba]sh interno do container
- `-v` para [mapear caminhos](https://docs.docker.com/storage/volumes/#start-a-container-with-a-volume) do hospedeiro (host) para dentro do container. Pode ser ReadOnly ou bidirecional.
- O volume pode ser um caminho arbitrário ou um volume pré-criado `docker volume create NOME_DO_VOLUME`. Nesse caso o caminho do volume no hospedeiro é definido pelo Docker, geralmente em /var/lib/docker
- O `-p` serve para mapear portas do host para o container. Isso é muito utilizado em aplicações web, onde o mundo externo precisa acessar um serviço que está isolado no container.
- A porta mapeada deve estar livre no host.
- É possível limitar determinados protocolos (udp/tcp) e mapear faixas de portas com `-p 7000-8000:7000-8000` por exemplo.  
# D4 - ENVs e ARGs

# D5 - Comandos úteis
