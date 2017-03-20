#!/bin/bash
#
##################################################################
#  Script que faz a verificacao nos pontos de montagens existentes e
# informa se os mesmos estao em Read Write ou nao,
#  informando status CRITICAL caso nao estejam em RW.
#  Exemplo de execucao do script: [script.sh] [ponto-de-montagem]
#
# Criado em: 08/09/2016 por Wagner Garcez
#
# localizado em : /home/opuser/
#
########################################################################

# Entrada de Dados

DIR="$1"  # Ponto de montagem

if [ $# -lt 1 ]; then
    echo "UNKNOWN - Faltou utilizar os argumentos corretamente:[scrip.sh] [ponto de montagem]"
    exit 3
  fi


#Processamento de dados / Sa¦da de dados

#if [ -d $DIR ]; then
   # script do seu bkp

if mount | column -t | awk '{print $3}' | grep "^$DIR$" &> /dev/null; then

        if mount | column -t | awk '{print $3,$6}' | grep -i "(rw" | grep "^$DIR " &> /dev/null; then

                echo "OK: Ponto de montagen $DIR esta OK"
                exit 0

        else

                echo "CRITICAL: Ponto de montagem $DIR em Read-Only"
                exit 2
        fi

else
        echo "UNKNOW -$DIR não est montado ou ao existe"
        exit 3
fi
