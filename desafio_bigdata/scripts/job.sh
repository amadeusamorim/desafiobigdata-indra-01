echo -e "\n--- Executando script ---\n"
sleep 1

echo -e "\n--- Executando o script rollout.sh ---\n"
./rollout.sh
sleep 2
 
echo -e "\n--- Script rollout.sh efetuado nos conformes ---\n"
sleep 1

echo -e "\n--- Movendo o arquivo com a ingestão mais atual para a pasta "in" ---\n"
hdfs dfs -put /home/amadeus/implantacao/desafio_bigdata/dados/3_ingestao/* /dados/indiana_jones/in    
sleep 2
echo -e "\n--- Arquivo movido com sucesso ---\n"
sleep 1

echo -e "\n--- Movendo arquivos processados para a pasta "process" ---\n"
hdfs dfs -put /home/amadeus/implantacao/desafio_bigdata/dados/2_ingestao/* /dados/indiana_jones/process
sleep 2
echo -e "\n--- Arquivo movido com sucesso ---\n"
sleep 1

echo -e "\n--- Entrando na pasta de arquivos antigos ---\n"
cd /home/amadeus/implantacao/desafio_bigdata/dados/1_ingestao

echo -e "\n--- Arquivando dados com o .tar da pasta delete e ajustando o nome do arquivo .tar para a data de ontem ---\n"
yesterday=$(date +%d%m%Y -d "yesterday")
tar -cf dados_cliente_$yesterday.tar dados_cliente.txt
sleep 1

echo -e "\n--- Compactando o arquivo .tar (no processo ele irá para a pasta delete no HDFS) ---\n"
gzip dados_cliente_$yesterday.tar
sleep 1

echo -e "\n--- Movendo arquivos processados e compactados com mais de 1 dia para a pasta "delete" ---\n"
hdfs dfs -put /home/amadeus/implantacao/desafio_bigdata/dados/1_ingestao/*.tar.gz /dados/indiana_jones/delete
sleep 1

echo -e "\n--- Script job.sh efetuado com sucesso ---\n"
