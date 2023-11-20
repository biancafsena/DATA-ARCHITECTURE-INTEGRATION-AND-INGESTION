#########################################################
# Curso: Data Science and Artificial Intelligence
# Disciplina: Data Architecture, Integration and Ingestion
# Data: 2023
# Prof.: Ivan Gancev - profivan.gancev@fiap.com.br
#        Leandro Mendes - profleandro.mendes@fiap.com.br
#########################################################

####### PREPARAÇÃO DA IMAGEM MYSQL
--Baixar imagem docker mais recente do Ubuntu
docker pull ubuntu:latest

--Cirar um container a partir da imagem baixada
docker run --name MyContainer -it ubuntu bash

--Atualizar lista de pacotes
apt update

--Verificar se a imagem está nos pacotes
apt list | grep mysql-server

--baixar imagem do mysql
apt-get install --download-only mysql-server

--Criar uma imagem a partir de um container
docker commit MyContainer ubuntusql

--Criar tag a partir da imagem gerada
docker tag ubuntusql:latest ivangancev/ubuntusql:latest

--Fazer o push para o repositorio
docker push ivangancev/ubuntusql:latest

####### PRE-REQ AULA EXERC MYSQL
--Baixar imagem do repositório
docker pull ivangancev/ubuntusql:latest

####### PRE-REQ AULA EXERC Cassandra
--Baixar imagem do repositório
docker pull cassandra



####### GIT HUB
git clone https://github.com/ivangancev/dts.git


####### COMANDOS ÚTEIS
--Caso saia do Container, liste os containers
docker container ls -a
--Inicie o container
docker container start MyContainer
--Conecte no container
docker container exec -it MyContainer bash
--Ver usuário no MySQL
select current_user();