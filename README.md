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
- volumes
- ports

# D4 - ENVs e ARGs

# D5 - Comandos úteis
