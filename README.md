# Flixtel — Projeto de Banco de Dados

**Integrantes do projeto:**

- **Bruno Silva Defelicibus** — 571 | GES
- **Gabriel Fonseca Ferreira** — 2193 | GEC
## 1. Sobre o projeto

O **Flixtel** é um projeto acadêmico de banco de dados para uma plataforma de streaming. O banco foi desenvolvido em **MySQL** e permite armazenar usuários, assinaturas, perfis, filmes, atores, elenco e histórico de filmes assistidos.

O script de criação e manipulação do banco está no arquivo `flixtel.sql`.

## 2. Estrutura do banco

O banco de dados utilizado é `flixtel_bd`. Ele possui as seguintes tabelas:

- **Usuario:** armazena os dados dos usuários cadastrados.
- **Assinaturas:** registra o plano, a mensalidade, o vencimento e o status da assinatura.
- **Perfil:** armazena os perfis associados a cada usuário, incluindo a classificação etária.
- **Filme:** guarda o título, a duração, o ano de lançamento, a sinopse e a classificação etária dos filmes.
- **Ator:** armazena informações dos atores.
- **Elenco:** relaciona atores e filmes, registrando também o personagem interpretado.
- **Historico_Assistido:** registra quais filmes foram assistidos por cada perfil e a data da visualização.

### Relacionamentos

- **Usuario e Perfil:** um usuário pode possuir vários perfis (1:N).
- **Filme e Ator:** um filme pode possuir vários atores, e um ator pode participar de vários filmes (N:M), por meio da tabela `Elenco`.
- **Perfil e Filme:** um perfil pode assistir a vários filmes, e um filme pode ser assistido por vários perfis (N:M), por meio da tabela `Historico_Assistido`.
- **Usuario e Assinaturas:** o script relaciona as tabelas por uma chave estrangeira. Os dados inseridos apresentam uma assinatura por usuário, mas a estrutura atual não impede que um usuário tenha mais de uma. Para garantir o relacionamento 1:1, adicione uma restrição `UNIQUE` em `Assinaturas.id_usuario_assinatura`.

## 3. Inserção e manipulação dos dados

O script insere dados fictícios para testar o funcionamento do banco. Após a execução completa, considerando a exclusão do ator de ID 6 e a criação automática de um perfil pelo trigger, as tabelas ficam com pelo menos cinco registros cada.

Foram utilizados os seguintes comandos:

- **INSERT:** utilizado para cadastrar usuários, assinaturas, perfis, filmes, atores, elenco e histórico de visualização.
- **UPDATE:** utilizado para atualizar a classificação etária dos filmes e também é executado pela procedure para alterar o plano de uma assinatura.
- **DELETE:** utilizado para remover um ator pelo seu ID, demonstrando a exclusão de registros.
- **SELECT:** utilizado para consultar os dados, filtrar resultados e gerar informações agrupadas, como quantidade de perfis por classificação e faturamento por plano.
- **ALTER TABLE:** utilizado para adicionar a coluna `classificacao_idade` à tabela `Filme`. Esse comando é de definição da estrutura do banco (DDL), e não de manipulação de dados (DML).

## 4. Usuários e ROLE

Foram criados dois usuários de acesso ao banco: `dev_Gabriel` e `dev_Bruno`.

Os dois foram associados à role `dev_junior`, que recebeu as permissões de `SELECT` e `INSERT` em todas as tabelas do banco `flixtel_bd`. Dessa forma, os usuários compartilham o mesmo conjunto de permissões, facilitando o gerenciamento dos acessos.

> **Observação:** no script, o trecho `@'host'` é um valor de exemplo. Para executar localmente, substitua `host` por `localhost` ou pelo endereço de host adequado ao ambiente MySQL utilizado.

## 5. Consultas com JOIN

O projeto contém consultas com `INNER JOIN` para combinar informações de tabelas relacionadas:

- **Usuario + Assinaturas:** consulta os dados dos usuários junto com seus planos e valores de mensalidade. A consulta está identificada no script como 1:1; para que o banco realmente imponha essa cardinalidade, é necessário adicionar a restrição `UNIQUE` mencionada na seção 2.
- **Usuario + Perfil (1:N):** apresenta os perfis e suas classificações etárias junto ao usuário responsável.
- **Perfil + Historico_Assistido + Filme (N:M):** mostra os filmes assistidos por cada perfil e as respectivas datas de visualização.

## 6. Objetos do banco de dados

Foram implementados quatro objetos para demonstrar recursos do MySQL:

### View — `vw_catalogo_completo`

Reúne informações de filmes, atores e personagens em uma única consulta. Foi criada para facilitar a visualização do catálogo com os dados do elenco, sem precisar escrever novamente os `JOINs`.

### Function — `fn_calcular_horas_filme`

Recebe a duração de um filme em minutos e retorna esse valor convertido para horas. Foi criada para reutilizar o cálculo em consultas.

### Procedure — `sp_mudar_plano`

Recebe o ID de uma assinatura e o novo plano. Atualiza o plano e define automaticamente a mensalidade correspondente: Básico, Padrão ou Premium. Foi criada para centralizar e facilitar a alteração das assinaturas.

### Trigger — `tr_criar_perfil_padrao`

É executada depois da inserção de um novo usuário na tabela `Usuario`. Sua função é criar automaticamente um perfil chamado `Meu Perfil`, com classificação etária `18`. Foi criada para automatizar a criação do perfil inicial.

## 7. Como executar

1. Abra o MySQL Workbench ou outro cliente MySQL.
2. Abra o arquivo `flixtel.sql`.
3. Confira e ajuste o host dos comandos `CREATE USER`, se necessário.
4. Execute o script no ambiente MySQL.
5. Consulte as tabelas e execute as consultas para verificar os resultados.

**Atenção:** o início do script contém `DROP DATABASE IF EXISTS flixtel_bd`, que apaga o banco existente com esse nome antes de criá-lo novamente. Além disso, o final do script contém comandos `DROP` que removem a View, a Procedure, a Function e o Trigger recém-criados. Para manter esses objetos disponíveis após a execução, comente ou remova os quatro comandos `DROP` da seção final do arquivo.

## 8. Considerações finais

O projeto aplica os conceitos de criação de banco e tabelas, chaves primárias e estrangeiras, inserção e manipulação de dados, controle de acesso por usuários e roles, consultas com `JOIN` e criação de objetos programáveis no MySQL.
