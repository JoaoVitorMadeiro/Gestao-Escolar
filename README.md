# Sistema de Gestão Escolar - Projeto de Banco de Dados

![Gestão Escolar](https://i.ibb.co/TxMwbg1n/Apresenta-o-do-Software-SSE-1.png)

![Python](https://img.shields.io/badge/Python-3.12%2B-blue.svg)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange.svg)

Este repositório contém o projeto final da disciplina de Implantação de Banco de Dados, que consiste em um banco de dados completo para um sistema de gestão escolar e uma aplicação de linha de comando (CLI) em Python para interagir com ele.

## 📝 Sobre o Projeto

O objetivo deste projeto foi modelar, criar e popular um banco de dados relacional para um cenário fictício de uma instituição de ensino fundamental. Além da estrutura básica, foram implementados recursos avançados de banco de dados para garantir a integridade, segurança e automação dos dados. A aplicação em Python serve como uma interface para demonstrar o funcionamento e a manipulação dos dados.

## 👥 Equipe

* Francisco Estênio Silva Vasconcelos
* Levy Braga Saraiva
* Paulo Jose Ribeiro Souza
* Patricia Alves de Sousa
* Joao Vitor de Sousa Madeiro

## Modelo DER
![DER](https://i.ibb.co/WWDGwP4D/BD-Escola-Page-1.png)

## ✨ Funcionalidades

### Banco de Dados
O banco de dados foi projetado para ser robusto e eficiente, contando com:

* **Schema Relacional:** Tabelas para Alunos, Professores, Turmas, Disciplinas, Matrículas e Notas, com chaves e relacionamentos bem definidos.
* **Views:** Para simplificar consultas complexas e recorrentes.
* `vw_alunos_por_turma`: Lista todos os alunos de cada turma.
* `vw_professores_por_turma`: Mostra o professor responsável por cada turma.
* `vw_status_alunos_por_ano`: Agrupa a quantidade de alunos por status (ativo, inativo) a cada ano.
* `vw_turmas_disciplinas_professor`: Exibe uma relação de professores, suas turmas e as disciplinas lecionadas.
* **Procedures:** Para encapsular lógicas de negócio complexas.
    * `gerar_boletim`: Gera o boletim de um aluno específico a partir do seu CPF.
    * `consultar_vagas`: Mostra a quantidade de vagas totais, ativas e disponíveis em cada turma.
    * `listar_turmas_por_ano`: Retorna todas as turmas de um determinado ano letivo.
* **Triggers:** Para automações e validações em resposta a eventos no banco.
    * `transferir_aluno`: Atualiza automaticamente a contagem de vagas de uma turma quando o status de uma matrícula é alterado para "TRANSFERIDA".
* **Transactions:** Utilizadas nas operações críticas (como matrículas) para garantir a atomicidade e consistência dos dados.

### Aplicação de Linha de Comando (CLI)
Uma interface em Python para interagir com o banco de dados, permitindo:

* Realizar operações básicas de CRUD (Criar, Ler, Inserir, Deletar) na tabela de alunos.
* Executar e visualizar os resultados das `Views` e `Procedures`.
* Demonstrar o funcionamento da `Trigger` de transferência de matrícula.

## 🛠️ Tecnologias Utilizadas

* **Linguagem:** Python 3
* **Banco de Dados:** MySQL 8.0
* **Conector:** `mysql-connector-python`
