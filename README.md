# Firewall Iptables
![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

## Objetivos
1 - Criar uma regra. O usuário deverá informar:
- se a regra será criada no início ou final da lista
- em qual cadeia será criada a regra (Entrada, Saída, Encaminhamento)
- Alvo da Regra
  * Aceitar
  * Rejeitar
  * Descartar
- Opções de Filtragem (o usuário poderá escolher quantas quiser, e você deve colocar uma opção para encerrar a regra).
  * Endereço de Origem
  * Endereço de Destino
  * Protocolo
  * Porta de Origem
  * Porta de Destino
  * Endereço MAC
  * Estado
  * Interface de Entrada
  * Interface de Saída

2 - Configurar Política Padrão
- Usuário deverá informar:
  * Cadeia - Entrada, Saída, Encaminhamento
  * Alvo: Aceitar, Descartar
 
3 - Apagar uma regra 
- O usuário deverá informar: o em qual cadeia está a regra:
  * Entrada, Saída, Encaminhamento.
  * O número da regra a ser excluída.
    
4 - Listar todas as regras

5 - Apagar todas as regras

6 - Salvar as regras do firewall (criar um arquivo com nome informado pelo usuário)

7 - Restaurar as regras do firewall (restaurar do arquivo criado previamente)

Deve-se criar cada opção na forma de função. O menu principal e todos os
menus secundários devem ficar dentro de uma estrutura de repetição. Ao
término da execução de uma opção, deve-se voltar para o menu principal.
Deve existir uma opção que ao ser escolhida, encerra o menu e
consequentemente o script. Todas os dados de entrada e as saídas devem
aparecer em caixas do Dialog ou Zenity. Deve existir um botão adicional com
os dados dos participante.

## Como utilizar este repositório

Inicialmente clone este projeto para sua máquina

``` git clone git@github.com:magno-brito/Firewall-iptables.git ```

Após isso, um arquivo com o projeto estará em sua máquina local. Faça as modificações  neste aquirvo. Para marter o versionamento, crie uma branch em sua máquina para que você possa fazer os commits na sua branch pessoal (exemplo, branch Magno). Pare isso digite o seguinte comando:

``` git branch "Nome da branch" ```

Em seguida precisamos mudar o HEAD do git para a branch criada

```git checkout "Nome da branch```

Agora basta adicionar as mudanças feitas no arquivo ao git e commitar

```git add .```

```git commit -m "mensagem" ```

```git push origin "nome da branch" ```

