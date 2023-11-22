#########################################################
# Curso: Data Science and Artificial Intelligence
# Disciplina: Data Architecture, Integration and Ingestion
# Data: 16/mar/2023
# Prof.: Ivan Gancev - profivan.gancev@fiap.com.br
#        Leandro Mendes - profleandro.mendes@fiap.com.br
#########################################################

------------------------------------
--------PRÉ-REQUISITOS-------
--Baixar imagem do repositório
docker pull ivangancev/mongo:latest


--INÍCIO EXERCÍCIO
--1) Cirar um container a partir da imagem baixada
--docker run --name MySQL -p 3306:3306 -it ivangancev/ubuntusql:latest bash

--comando acima nao funciona com o processador M1

docker pull mysql

docker run --name meu-mysql -e MYSQL_ROOT_PASSWORD=senha -d mysql

docker exec -it meu-mysql bash

mysql -u root -p

f1@p
senha
------------------------------------
--INÍCIO EXERCÍCIO
--01) Cirar um container a partir da imagem baixada
docker run --name MyMongo -it mongo bash

--02) Verificar o diretório /data/db
cd /data/db

--03) Verificar os arquivos /etc/mongod.config.orig e /ect/mongo.conf 
cat /etc/mongod.conf.orig 
cat /etc/mongod.conf  -- - FALTA AQUI 

--04) Abra outra janela para verifcar os logs do mongo
docker container exec -it MyMongo bash
tail -f /var/log/mongodb/mongod.log

--05) Iniciar o serviço do MongoDB no container
mongod -f /etc/mongod.conf &

--06) Acessar o CLI do mongo
mongosh

--07) Criar um database chamado dbAula
use dbAula

--08) Listar todos os databases da instância
show dbs

--09) Verificar em qual database está conectado
db


------------------------------------
--COLLECTIONS

--10) Criar uma collection chamada collectionAuto
db.createCollection("collectionAuto")

--11) Listar as collections do database
show collections

--12) Inserir um documento na collectionAuto
db.collectionAuto.insert({"nome":"José da Silva","idade":"30","pais":["João da Silva","Maria Aparecida"],"contatos":{"emails":["joao@gmail.com","joao@fiap.com"],"telefones":["12345678","87654321"]}})

--13) Consultar todos os registros da collection
db.collectionAuto.find()

--14) Criar uma collection chamada collectionCustom
db.createCollection("collectionCustom",{capped:true,size:6142800,max:5})

--15) Inserir um documento na collectionCustom
db.collectionCustom.insert({"carrinho":"XPTO-456789","totalItens":3,"valorTotal":100,"dataEntrega":"30/06/2023","cliente":"12345678900","itens":{"item001":{"codigo":"10","nome":"arroz","valor":"30"},"item002":{"codigo":"20","nome":"feijão","valor":"30"},"item003":{"codigo":"30","nome":"batata","valor":"40"}}})

--16) Inserir o mesmo documento duas vezes
db.collectionCustom.insert({"carrinho":"XPTO-456789","totalItens":3,"valorTotal":100,"dataEntrega":"30/06/2023","cliente":"12345678900","itens":{"item001":{"codigo":"10","nome":"arroz","valor":"30"},"item002":{"codigo":"20","nome":"feijão","valor":"30"},"item003":{"codigo":"30","nome":"batata","valor":"40"}}})

--17) Inserir 5 registros na collectionCustom
db.collectionCustom.insert({"chave1":"10","chave2":"10"})
db.collectionCustom.insert({"chave1":"20","chave2":"20"})
db.collectionCustom.insert({"chave1":"30","chave2":"30"})
db.collectionCustom.insert({"chave1":"40","chave2":"40"})
db.collectionCustom.insert({"chave1":"50","chave2":"50"})

--18) Localizar 1 documento na collectionCustom
db.collectionCustom.find({"chave1":"50"})

--19) Importar registros usando o mongoimport
Criar arquivo /tmp/import_mongo.json com o conteúdo abaixo usando o nano:
{"chave1":"60","chave2":"600"}
{"chave1":"61","chave2":"601"}
{"chave1":"62","chave2":"602"}
{"chave1":"63","chave2":"603"}
{"chave1":"64","chave2":"604"}

Execute o comando:
mongoimport --db dbAula --collection collectionAuto --file /tmp/import_mongo.json

--20) Consulte todos os registros de collectionAuto
db.collectionAuto.find()

------------------------------------
--COLLECTIONS ÍNDICES

--21) Criar um índice na collectionAuto
db.collectionAuto.createIndex({"chave1":1})
Especificando o nome do índice:
db.collectionAuto.createIndex({"chave1":2},{"name":"MeuIndice"})


--22) Criar um índice de texto na collectionAuto
db.collectionAuto.createIndex({"chave2":"text"})

--23) Criar um índice composto na collectionAuto
db.collectionAuto.createIndex({"chave1":1,"chave2":1})

--24) Consultar todos os índices da collectionAuto
db.collectionAuto.getIndexes()

--25) Usar o explain na consulta 
db.collectionAuto.find({'chave1':'60'}).explain()

--26) Fazer uma consulta com hint na collectionAuto 
db.collectionAuto.find({'chave1':'60'}).hint({ chave1: 1, chave2: 1 }).explain()

--27) Apagar um dos índices da collectionAuto
db.collectionAuto.dropIndex({ "chave1": 1, "chave2": 1 })

--28) Apagar todos os índices da collectionAuto
db.collectionAuto.dropIndexes()

------------------------------------
--COLLECTIONS FILTROS
-- Pré-req: Crie uma collection chamada "calcados"
-- Pré-req: insira os documentos abaixo abaixo:
db.calcados.insert({"calcado":"tenis","fabricante":"nike","cor":"azul","tamanho":39,"preco":300.00})
db.calcados.insert({"calcado":"tenis","fabricante":"adidas","cor":"verde","tamanho":40,"preco":250.00})
db.calcados.insert({"calcado":"chinelo","fabricante":"havaianas","cor":"branco","tamanho":42,"preco":100.00})
db.calcados.insert({"calcado":"sapato","fabricante":"cns","cor":"preto","tamanho":41,"preco":320.00})
db.calcados.insert({"calcado":"sapatenis","fabricante":"democrata","cor":"marrom","tamanho":38,"preco":280.00})
db.calcados.insert({"calcado":"sandalia","fabricante":"arezzo","cor":"prata","tamanho":36,"preco":200.00})
db.calcados.insert({"calcado":"chinelo","fabricante":"ipanema","cor":"azul","tamanho":37,"preco":50.0})

--29) Fazer pesquisa com um valor exato
db.calcados.find({"calcado":"chinelo"})

--30) Fazer pesquisa com o operador LT
db.calcados.find({"preco":{$lt:300.00}})

--31) Fazer pesquisa com o operador GT
db.calcados.find({"preco":{$gt:200.00}})

--32) Fazer pesquisa com operador NE
db.calcados.find({"calcado":{$ne:"tenis"}})

--33) Fazer pesquisa com operador AND
db.calcados.find( { $and: [ {"calcado":"tenis"} , {"fabricante":"nike"} ] } )

--34) Fazer pesquisa com operador OR
db.calcados.find( { $or: [ {"calcado":"tenis"} , {"calcado":"chinelo"} ] } )

--35) Fazer pesquisa filtrando exibição de campos
db.calcados.find({"calcado":"chinelo"},{"fabricante":1,"preco":1})

--36) Fazer pesquisa com limite de documentos
db.calcados.find({"preco":{$gt:200.00}}).limit(2)

--37) Fazer pesquisa desconsiderando documentos
db.calcados.find({"preco":{$gt:200.00}}).skip(2)

--38) Fazer pesquisa com ordenação
db.calcados.find({"calcado":"chinelo"},{"fabricante":1,"preco":1}).sort({"fabricante":-1})

------------------------------------
--COLLECTIONS AGGREGATE
--39) Fazer contagem de documentos
db.calcados.aggregate([{$match:{"tamanho":{$gt:40}}},{$count:"qtde"}])

--40) Fazer soma de documentos
db.calcados.aggregate([{$match:{"calcado":"tenis"}},{$group:{"_id":"$fabricante",total:{$sum:"$preco"}}}])

--41) Fazer um agrupamento
db.calcados.aggregate([{$group:{"_id":"$calcado",total:{$count:{}}}}])

------------------------------------
--COLLECTIONS UPDATE / DELETE
--42) Atualizar um documento na collection calcados
db.calcados.find({ $and: [ {"calcado":"tenis"} , {"fabricante":"nike"} ] })
db.calcados.update({ $and: [ {"calcado":"tenis"} , {"fabricante":"nike"} ] }, {$set:{"tamanho":43}})
db.calcados.find({ $and: [ {"calcado":"tenis"} , {"fabricante":"nike"} ] })

--43) Atualizar mais de um docmento na collection calcados
db.calcados.find({"calcado":"tenis"})
db.calcados.update({"calcado":"tenis"}, {$set:{"preco":310}},{multi:true} )
db.calcados.find({"calcado":"tenis"})

--44) Remover documentos usando filtro na collection calcados
db.calcados.find({$and: [{"calcado":"sapato"}, {"fabricante":"cns"}]})
db.calcados.remove({$and: [{"calcado":"sapato"}, {"fabricante":"cns"}]})

--45) Remover todos os registros da collection calcados
db.calcados.remove({})


------- B O N U S ----------
####### COMANDOS DOCKER ÚTEIS
--Caso saia do Container, liste os containers
docker container ls -a
--Inicie o container
docker container start MyMongo
--Conecte no container
docker container exec -it MyMongo bash
