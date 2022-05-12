# Desafio Big Data | Indra 
Desafio da turma de formação em BI/Big Data promovida pela INDRA e Uniesp-PB

A intenção do desafio é de ingerir arquivos no HDFS através de comandos via bashc contidos na pasta Script, utilizando também conceitos iniciais de shell script.

Segue descritivo do desafio:

## ESCOPO
Você receberá em um pacote desafio_bigdata.zip que ira conter uma pasta "dados" com pastas e arquivos para serem ingeridos no HDFS, note que dentro da pasta dados existe uma ordem para que os arquivos sejam ingeridos, 1_ingestao, 2_ingestao, 3_ingestao, dentro de cada pasta possui um arquivo com dados_clientes.txt na sequencia de criação dos arquivos e uma **pasta vazia de "scripts"** onde vocês **deverão criar dois arquivos em shell** para executar os processos de criação do ambiente e a execução dos processos.

## TAREFA
No HDFS você terá que criar a segunte estrutura de diretórios

/dados/indiana_jones/in
/dados/indiana_jones/process
/dados/indiana_jones/delete

1 - Você terá que criar um script shell parta efetuar a criação (rollout) da estrutura que pode ser chamado de rollout.sh, neste script deverá ter todo o processo de criação das pastas e permissionamento.

2 - Criar outro script em shell (job.sh) para efetuar o trabalho de migração dos arquivos do linux para o hdfs.

Regras de Negócio (Atenção as Regras):

RN01 - na pasta /dados/indiana_jones/in só deverá conter o arquivo de ingestão mais atual
RN02 - na pasta /dados/indiana_jones/process deverá conter os arquivos já processados que tenham menos de 1 dias, arquivos com mais de 1 dias deve ser migrado para a pasta de delete
RN03 - na pasta /dados/indiana_jones/delete terá os arquivos compactados(tar/zip/tar.gz) com a data de compactação ex. dados_clientes_05052022.tar
