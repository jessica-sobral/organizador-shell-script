#!/bin/bash
#
# organizador.sh - painel principal do Organizador Automático de Arquivos
#
# objetivo: apresentar um menu para organizar arquivos por tipo/extensão,
# ver estatísticas de uso, desfazer a última organização e obter ajuda.

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$BASE_DIR/scripts"
LOG_DIR="$BASE_DIR/logs"
HISTORICO="$LOG_DIR/historico.log"
MANIFESTO="$LOG_DIR/ultima_operacao.tsv"

mkdir -p "$LOG_DIR"

PASTA_DOWNLOADS="$HOME/Downloads"

# cores para facilitar a leitura no terminal
VERDE='\033[0;32m'
VERMELHO='\033[0;31m'
AMARELO='\033[1;33m'
AZUL='\033[0;34m'
NC='\033[0m'

exibir_menu() {
    clear
    echo -e "${AZUL}======================================${NC}"
    echo -e "${AZUL} ORGANIZADOR AUTOMÁTICO DE ARQUIVOS${NC}"
    echo -e "${AZUL}======================================${NC}"
    echo "1 - Organizar Downloads"
    echo "2 - Organizar outra pasta"
    echo "3 - Mostrar estatísticas"
    echo "4 - Desfazer última organização"
    echo "5 - Ajuda"
    echo "6 - Sair"
    echo -e "${AZUL}======================================${NC}"
}

pausar() {
    echo ""
    read -p "Pressione ENTER para voltar ao menu..." dummy
}

# loop de repetição (while) mantendo o menu ativo até o usuário escolher sair
opcao=""
while [ "$opcao" != "6" ]; do
    exibir_menu
    read -p "Escolha uma opção: " opcao

    # estrutura condicional (case funciona como uma série de if/else)
    case "$opcao" in
        1)
            if [ -d "$PASTA_DOWNLOADS" ]; then
                bash "$SCRIPTS_DIR/organizar.sh" "$PASTA_DOWNLOADS" "$HISTORICO" "$MANIFESTO"
            else
                echo -e "${VERMELHO}A pasta Downloads não foi encontrada em: $PASTA_DOWNLOADS${NC}"
            fi
            pausar
            ;;
        2)
            read -p "Informe o caminho completo da pasta a organizar: " pasta
            if [ -d "$pasta" ]; then
                bash "$SCRIPTS_DIR/organizar.sh" "$pasta" "$HISTORICO" "$MANIFESTO"
            else
                echo -e "${VERMELHO}Diretório inválido: $pasta${NC}"
            fi
            pausar
            ;;
        3)
            bash "$SCRIPTS_DIR/estatisticas.sh" "$HISTORICO"
            pausar
            ;;
        4)
            bash "$SCRIPTS_DIR/desfazer.sh" "$MANIFESTO"
            pausar
            ;;
        5)
            bash "$SCRIPTS_DIR/ajuda.sh"
            pausar
            ;;
        6)
            echo -e "${AMARELO}Encerrando o Organizador Automático de Arquivos...${NC}"
            ;;
        *)
            echo -e "${VERMELHO}Opção inválida! Escolha um número de 1 a 6.${NC}"
            sleep 1
            ;;
    esac
done