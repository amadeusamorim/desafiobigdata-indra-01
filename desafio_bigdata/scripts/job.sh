#!/bin/bash

echo -e "\n--- Executando script ---\n"
sleep 1

echo -e "\n--- Entrando na pasta scripts ---\n"
cd /home/amadeus/implantacao/desafio_bigdata/scripts

echo -e "\n--- Executando o script rollout.sh ---\n"
./rollout.sh
sleep 2
 
echo -e "\n--- Script rollout.sh efetuado nos conformes ---\n"
sleep 1

echo -e "\n--- Movendo o arquivo com a ingestão mais atual para a pasta "in" ---\n"
cd /home/amadeus/implantacao/desafio_bigdata/dados/2_ingestao

# Contando a quantidade de linhas que tenho no meu arquivo dados_cliente.txt (source)
size_src=$(cat ./*.txt | wc -l)

# Contando a quantidade de linhas que tenho no arquivo dados_cliente.txt
size_hdfs_in=$(hdfs dfs -cat /dados/indiana_jones/in/dados_cliente.txt | wc -l)

# Contando a quantidade de arquivos que tenho na pasta in
file_in=$(hdfs dfs -count /dados/indiana_jones/in/*.txt | wc -l)

if [ $file_in -gt 0 ]; then
    if [ $file_src -gt $file_hdfs_in ]; then
        echo -e "\n--- Removendo arquivo antigo ---\n"
        hdfs dfs -rm /dados/indiana_jones/in/dados_cliente.txt
        sleep 2
        echo -e "\n--- Inserindo arquivo novo ---\n"
	hdfs dfs -put * /dados/indiana_jones/in 
    	else
        echo -e "\n--- Arquivo já existente ---\n"
    fi
else
hdfs dfs -put * /dados/indiana_jones/in 
fi

sleep 2
echo -e "\n--- Arquivo atualizado ---\n"
sleep 1

echo -e "\n--- Movendo arquivos processados para a pasta "process" ---\n"
cd /home/amadeus/implantacao/desafio_bigdata/dados/2_ingestao

# Contando a quantidade de arquivos que tenho na pasta process
file_process=$(hdfs dfs -count /dados/indiana_jones/process/*.txt | wc -l)

# Contando a quantidade de linhas do meu arquivo dados_cliente.txt
size_hdfs_prc=$(hdfs dfs -cat /dados/indiana_jones/process/dados_cliente.txt | wc -l)

if [ $file_process -gt 0 ]; then
    if [ $file_src -gt $file_hdfs_prc ]; then
        echo -e "\n--- Removendo arquivo antigo ---\n"
        hdfs dfs -rm /dados/indiana_jones/process/dados_cliente.txt
        sleep 2
        echo -e "\n--- Inserindo arquivo novo ---\n"
        hdfs dfs -put * /dados/indiana_jones/process 
    else
        echo -e "\n--- Arquivo já existente ---\n"
    fi
else
hdfs dfs -put * /dados/indiana_jones/process
fi

sleep 2
echo -e "\n--- Arquivo atualizado ---\n"
sleep 1

echo -e "\n--- Entrando na pasta de arquivos antigos ---\n"
cd /home/amadeus/implantacao/desafio_bigdata/dados/1_ingestao

# Quantos arquivos tenho na minha pasta delete
file_delete=$(hdfs dfs -count /dados/indiana_jones/delete/*.tar.gz | wc -l)

echo -e "\n--- Arquivando dados com o .tar da pasta delete e ajustando o nome do arquivo .tar para a data de ontem ---\n"

# Passando uma variável dinâmica 
yesterday=$(date +%d%m%Y -d "yesterday")

tar -cf dados_cliente_$yesterday.tar dados_cliente.txt
sleep 1
echo -e "\n--- Compactando o arquivo .tar (no processo ele irá para a pasta delete no HDFS) ---\n"

gzip dados_cliente_$yesterday.tar -f
sleep 1

echo -e "\n--- Movendo arquivos processados e compactados com mais de 1 dia para a pasta "delete" ---\n"

if [ $file_delete -gt 10 ]; then
        hdfs -rm /dados/indiana_jones/delete/*.txt
        echo -e "\n--- Apagando backups antigos ---\n"
fi

hdfs dfs -put *.tar.gz /dados/indiana_jones/delete
sleep 1

echo -e "\n--- Script job.sh efetuado com sucesso ---\n"
