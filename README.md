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

- `ARGS` ficam disponíveis durante o `build` e podem ser passados por linha de comando. 
- Para que `ARGS` sejam utilizados eles precisam ser definidos no Dockerfile (diretiva `ARG`)
- `ARGS` podem ser definidos com valores default `ARG nome=default`.
- `ARGS` não ficam diretamente disponíveis durante o `run`. Para que isso seja possível é necessário definir uma variável de ambiente (`ENV`) que recebe o valor do `ARG`.
- `ARGS` podem ser passados com o parâmetro `--build-arg nome=default`, que pode ser definido várias vezes (um para cada `ARG`)
- Variáveis de ambiente `ENV` são uma construção bem antiga e standard dos sistemas linux, podendo ser acessadas por qualquer linguagem de programação moderna
- No docker, as variáveis de ambiente do hospedeiro **não** são automaticamente disponibilizadas dentro do container.
- Você pode passar variáveis de ambiente usando a tag `-e variavel=valor` dentro durante o `run` ou criando um "env file" e especificando a tag `--env-file .env`.


# D5 - Comandos úteis
- `docker pull`: faz o download da versão mais atual de uma imagem/tag
- `docker create --name container_name image_name:tag`: cria o container sem executá-lo
- `docker start|stop|kill`: gerencia o ciclo de vida dos containers
- `docker ps`: lista todos os containers ativos. Parecido com `docker container ls`. `-a` faz com que os containers desligados apareçam também na lista
- `docker inspect`: imprime todas as informações de um componente docker. Funciona com volumes, imagens e containers.  Útil para debug.
- `docker volume ls`: lista os volumes existentes
- `docker container|image|system prune`: limpeza (especialmente de disco) dos componentes docker
- `docker logs (-f) container_name`: imprime os logs de um container. O `-f` faz com que os logs novos continuem sendo mostrados.  

# D6 - Docker Compose