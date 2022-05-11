#!/bin/bash

echo -e "\n--- Criando pastas para o hdfs ---\n"
hdfs dfs -mkdir -p /dados/indiana_jones/in
hdfs dfs -mkdir -p /dados/indiana_jones/process
hdfs dfs -mkdir -p /dados/indiana_jones/delete
sleep 1

echo -e "\n--- Pastas criadas com sucesso ---\n"
sleep 2
