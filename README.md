# 🍔 Projeto de Banco de Dados — Lanchonete

Projeto de banco de dados desenvolvido para uma **lanchonete**, com o objetivo de modelar e organizar as principais operações do estabelecimento, incluindo clientes, produtos, pedidos, pagamentos, entregas e controle de ingredientes.

O projeto foi desenvolvido com foco em **modelagem de dados, SQL e recursos avançados de bancos de dados relacionais**, utilizando PostgreSQL.

---

## 📌 Sobre o projeto

O banco foi projetado para atender às necessidades de uma lanchonete, permitindo o gerenciamento de:

- 👤 Clientes
- 🍔 Produtos
- 🧂 Ingredientes
- 📦 Pedidos
- 🛒 Itens dos pedidos
- 💳 Pagamentos
- 💰 Pagamentos fiados
- 🚴 Entregadores
- 🛵 Entregas
- 📊 Consultas e relatórios
- ⚙️ Funções armazenadas
- 🔄 Gatilhos (Triggers)
- 👁️ Visões (Views)
- ⚡ Índices para otimização

O projeto também contém dados de exemplo para possibilitar a execução e validação das consultas desenvolvidas.

---

## 🛠️ Tecnologias

- **PostgreSQL**
- **SQL**
- **PL/pgSQL**
- **Modelo Entidade-Relacionamento (ER)**

---

## 🗂️ Estrutura do projeto

```text
projeto-banco-dados-lanchonete/
│
├── diagram/
│   └── Modelo ER Lanchonete.brM3
│
├── docs/
│   └── Projeto Banco de Dados.pdf
│
├── sql/
│   ├── schema/
│   │   └── Criado as Tabelas.sql
│   │
│   ├── seed/
│   │   └── Criando Inserções.sql
│   │
│   ├── queries/
│   │   └── Consultas.sql
│   │
│   ├── functions/
│   │   └── Criando Funções Armazenadas.sql
│   │
│   ├── triggers/
│   │   └── Criando Gatilhos.sql
│   │
│   ├── views/
│   │   └── Criando Visões.sql
│   │
│   └── indexes/
│       └── Criando Índices.sql
│
├── .gitignore
└── README.md
```

---

## 🧩 Modelagem do banco

O modelo contempla entidades relacionadas às operações da lanchonete.

Entre as principais entidades estão:

- `cliente`
- `produto`
- `ingrediente`
- `produto_ingrediente`
- `pedido`
- `item_pedido`
- `pagamento`
- `pagamento_pix`
- `pagamento_cartao`
- `pagamento_dinheiro`
- `pagamento_fiado`
- `entregador`
- `entrega`

A modelagem utiliza **chaves primárias, chaves estrangeiras, restrições de integridade e relacionamentos entre as entidades**.

---

## 📐 Modelo Entidade-Relacionamento

O projeto possui um diagrama ER desenvolvido durante a modelagem do banco.

> O arquivo do modelo está disponível no diretório `diagram/`.

---

## 🗄️ Estrutura SQL

### 1. Schema

O script de criação do banco contém as tabelas, relacionamentos e restrições necessárias para estruturar o sistema.

```text
sql/schema/Criado as Tabelas.sql
```

Entre os recursos utilizados estão:

- `PRIMARY KEY`
- `FOREIGN KEY`
- `UNIQUE`
- `CHECK`
- `DEFAULT`
- `ON UPDATE CASCADE`
- `ON DELETE CASCADE`

---

### 2. Dados iniciais

O projeto possui um conjunto de dados para testes e demonstração das funcionalidades.

```text
sql/seed/Criando Inserções.sql
```

São inseridos registros de exemplo para clientes, produtos, ingredientes, pedidos, pagamentos, entregadores e demais entidades.

---

## 🔎 Consultas SQL

O projeto contém diversas consultas para extração de informações do banco.

```text
sql/queries/Consultas.sql
```

Entre os exemplos estão:

- Listagem de clientes e entregadores
- Clientes que já realizaram pedidos
- Histórico de pedidos
- Itens de um pedido
- Faturamento diário
- Faturamento mensal
- Produtos mais vendidos
- Clientes VIP
- Produtos específicos
- Clientes sem e-mail
- Pagamentos pendentes
- Pagamentos fiados em aberto
- Total de dívida por cliente
- Horário de maior movimento
- Ticket médio
- Produtos nunca vendidos
- Entregas em andamento
- Pedidos atrasados

Também são utilizados recursos como:

- `JOIN`
- `INNER JOIN`
- `UNION`
- `EXISTS`
- `NOT EXISTS`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIKE`
- funções de agregação
- subconsultas

---

## ⚙️ Funções armazenadas

O banco utiliza funções armazenadas desenvolvidas em **PL/pgSQL**.

```text
sql/functions/Criando Funções Armazenadas.sql
```

Entre as funções implementadas estão:

### `calcular_total_pedido()`

Calcula o valor total dos itens de um pedido.

### `calcular_faturamento_diario()`

Calcula o faturamento de uma determinada data considerando pagamentos confirmados.

### `calcular_ticket_medio()`

Calcula o ticket médio dos pedidos não cancelados.

### `verificar_pedido_atrasado()`

Permite verificar se determinado pedido está atrasado.

O uso de funções permite centralizar determinadas regras e operações diretamente no banco de dados.

---

## 🔄 Gatilhos — Triggers

O projeto também utiliza **Triggers** para automatizar determinadas regras do banco.

```text
sql/triggers/Criando Gatilhos.sql
```

Entre os comportamentos implementados estão:

- Atualização automática do status do pedido após confirmação do pagamento
- Registro automático do horário de saída para entrega
- Registro automático do horário de conclusão da entrega
- Bloqueio da inclusão de produtos indisponíveis em pedidos

Exemplo de fluxo:

```text
Pagamento confirmado
        ↓
Trigger executada
        ↓
Pedido atualizado
        ↓
Status = EM PREPARO
```

---

## 👁️ Views

Foram criadas visões para facilitar o acesso a informações utilizadas com frequência.

```text
sql/views/Criando Visões.sql
```

Entre elas:

- `vw_cliente_pedido`
- `vw_produtos_disponiveis`
- `vw_pedidos_andamento`
- `vw_entregas`
- `vw_faturamento_diario`
- `vw_clientes_fiado`

As Views permitem encapsular consultas e disponibilizar informações de forma mais organizada.

---

## ⚡ Índices

O projeto possui índices para melhorar o desempenho das consultas.

```text
sql/indexes/Criando Índices.sql
```

Foram criados índices para campos utilizados frequentemente em:

- buscas
- filtros
- relacionamentos
- ordenações
- consultas por status

Exemplos:

```sql
CREATE INDEX idx_cliente_nome
ON cliente(nome);
```

```sql
CREATE INDEX idx_pedido_status
ON pedido(status);
```

```sql
CREATE INDEX idx_entrega_status
ON entrega(statusEntrega);
```

---

## 🚀 Como executar o projeto

### Pré-requisitos

É necessário possuir:

- PostgreSQL instalado
- Um cliente SQL, como pgAdmin ou DBeaver

### 1. Criar o banco

Crie um novo banco de dados PostgreSQL.

Exemplo:

```sql
CREATE DATABASE lanchonete;
```

### 2. Executar o script de tabelas

Execute:

```text
sql/schema/Criado as Tabelas.sql
```

### 3. Inserir os dados

Depois execute:

```text
sql/seed/Criando Inserções.sql
```

### 4. Criar as funções

Execute:

```text
sql/functions/Criando Funções Armazenadas.sql
```

### 5. Criar os gatilhos

Execute:

```text
sql/triggers/Criando Gatilhos.sql
```

### 6. Criar as Views

Execute:

```text
sql/views/Criando Visões.sql
```

### 7. Criar os índices

Execute:

```text
sql/indexes/Criando Índices.sql
```

### 8. Executar as consultas

Por fim, utilize:

```text
sql/queries/Consultas.sql
```

para testar e explorar os dados.

---

## 📚 Documentação

A documentação completa do projeto está disponível em:

```text
docs/Projeto Banco de Dados.pdf
```

---

## 🎯 Objetivos de aprendizagem

Este projeto foi desenvolvido com o objetivo de praticar e consolidar conhecimentos em:

- Modelagem de bancos de dados relacionais
- Modelo Entidade-Relacionamento
- Normalização e relacionamentos
- SQL
- PostgreSQL
- Chaves primárias e estrangeiras
- Integridade referencial
- Consultas complexas
- Funções armazenadas
- PL/pgSQL
- Triggers
- Views
- Índices
- Otimização de consultas
- Manipulação de dados

---

## 👨‍💻 Autor

**Juan Rodrigues**

Estudante de **Análise e Desenvolvimento de Sistemas — IFPB**.

Interesses em:

- Desenvolvimento de Software
- Backend
- Banco de Dados
- SQL
- Desenvolvimento de aplicações

---

## 📄 Licença

Este projeto foi desenvolvido para fins acadêmicos e de portfólio.