# Makefile - Organizador Automático de Arquivos
# automação de tarefas via make

.PHONY: permissoes run test clean

permissoes:
	chmod +x organizador.sh scripts/*.sh tests/*.sh

run: permissoes
	./organizador.sh

test: permissoes
	bash tests/test_organizador.sh

clean:
	rm -f logs/historico.log logs/ultima_operacao.tsv
	@echo "Logs limpos."