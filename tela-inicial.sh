#!/bin/bash

#Para o ícone utilizamos a tabela de ícones do gnome (https://developer-old.gnome.org/icon-naming-spec/)

inicio=$(zenity --icon-name="security-high" --info \
	--title="Iptables" --text="
	Bem-vindo ao nosso sistema
       	de configuração de iptables
	Aqui você poderá criar, editar
	e excluir regras de iptables

	Este trabalho foi feito por

       	Magno, Murilo e Roger
	
	:) 

	"\
	--width=10\
	--height=100)

if [ $inicio ]
       	item=$(zenity --list --text "Selecione uma opção"\
		--radiolist \
		--column "Marcar" \
		--column "Ação" \
		TRUE "Criar uma regra" \
		FALSE "Configurar Política Padrão" \
		FALSE "Apagar um regra" \
		FALSE "Listar uma Regra" \
		FALSE "Listar todas as regras" \
		FALSE "Apagar todas as regreas" \
		FALSE "Salvar as regrass do firewall" \
		FALSE "Restaurar as regras do firewall"\
	)
then echo "Deu certo $item"
fi

