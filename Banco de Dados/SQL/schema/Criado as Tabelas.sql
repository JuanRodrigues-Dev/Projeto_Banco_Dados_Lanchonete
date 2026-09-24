CREATE TABLE cliente (
    idCliente SERIAL,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100),
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(60) NOT NULL,
    pontoReferencia VARCHAR(150),
    CONSTRAINT cliente_pk
        PRIMARY KEY (idCliente)
);

CREATE TABLE produto (
    idProduto SERIAL,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco DECIMAL(10,2) NOT NULL,
    tipoProduto VARCHAR(50) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    disponivel BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT produto_pk
        PRIMARY KEY(idProduto),
    CONSTRAINT produto_preco_check
        CHECK(preco >= 0)
);

CREATE TABLE ingrediente (
    idIngrediente SERIAL,
    nome VARCHAR(80) NOT NULL UNIQUE,
    tipo VARCHAR(50),
    CONSTRAINT ingrediente_pk
        PRIMARY KEY(idIngrediente)
);

CREATE TABLE produto_ingrediente (
    idProduto INTEGER NOT NULL,
    idIngrediente INTEGER NOT NULL,
    CONSTRAINT produto_ingrediente_pk
        PRIMARY KEY(idProduto,idIngrediente),
    CONSTRAINT produto_ingrediente_produto_fk
        FOREIGN KEY(idProduto)
        REFERENCES produto(idProduto)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT produto_ingrediente_ingrediente_fk
        FOREIGN KEY(idIngrediente)
        REFERENCES ingrediente(idIngrediente)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE pedido (
    idPedido SERIAL,
    dataHora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) NOT NULL DEFAULT 'AGUARDANDO PAGAMENTO',
    valorTotal DECIMAL(10,2) NOT NULL DEFAULT 0,
    observacao VARCHAR(255),
    idCliente INTEGER NOT NULL,
    CONSTRAINT pedido_pk
        PRIMARY KEY(idPedido),
    CONSTRAINT pedido_cliente_fk
        FOREIGN KEY(idCliente)
        REFERENCES cliente(idCliente)
        ON UPDATE CASCADE,
    CONSTRAINT pedido_valor_check
        CHECK(valorTotal >=0),
    CONSTRAINT pedido_status_check
        CHECK(status IN
        (
            'AGUARDANDO PAGAMENTO',
            'EM PREPARO',
            'PRONTO',
            'SAIU PARA ENTREGA',
            'ENTREGUE',
            'CANCELADO'
        ))
);

CREATE TABLE item_pedido (
    idItem SERIAL,
    quantidade INTEGER NOT NULL,
    precoUnitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    observacao VARCHAR(255),
    idPedido INTEGER NOT NULL,
    idProduto INTEGER NOT NULL,
    CONSTRAINT item_pedido_pk
        PRIMARY KEY(idItem),
    CONSTRAINT item_pedido_pedido_fk
        FOREIGN KEY(idPedido)
        REFERENCES pedido(idPedido)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT item_pedido_produto_fk
        FOREIGN KEY(idProduto)
        REFERENCES produto(idProduto)
        ON UPDATE CASCADE,
    CONSTRAINT item_quantidade_check
        CHECK(quantidade > 0),
    CONSTRAINT item_preco_check
        CHECK(precoUnitario >=0),
    CONSTRAINT item_subtotal_check
        CHECK(subtotal >=0)
);

CREATE TABLE pagamento (
    idPagamento SERIAL,
    valorPago DECIMAL(10,2) NOT NULL,
    statusPagamento VARCHAR(30) NOT NULL,
    dataGeracao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataConfirmacao TIMESTAMP,
    idPedido INTEGER NOT NULL UNIQUE,
    CONSTRAINT pagamento_pk
        PRIMARY KEY(idPagamento),
    CONSTRAINT pagamento_pedido_fk
        FOREIGN KEY(idPedido)
        REFERENCES pedido(idPedido)
        ON UPDATE CASCADE,
    CONSTRAINT pagamento_valor_check
        CHECK(valorPago >=0),
    CONSTRAINT pagamento_status_check
        CHECK(statusPagamento IN
        (
            'PENDENTE',
            'CONFIRMADO',
            'CANCELADO',
            'FIADO_ABERTO'
        ))
);

CREATE TABLE pagamento_pix (
    idPagamento INTEGER,
    codigoPix VARCHAR(255) NOT NULL,
    CONSTRAINT pagamento_pix_pk
        PRIMARY KEY(idPagamento),
    CONSTRAINT pagamento_pix_fk
        FOREIGN KEY(idPagamento)
        REFERENCES pagamento(idPagamento)
        ON DELETE CASCADE
);

CREATE TABLE pagamento_cartao (
    idPagamento INTEGER,
    tipoCartao VARCHAR(20) NOT NULL,
    bandeiraCartao VARCHAR(40),
    CONSTRAINT pagamento_cartao_pk
        PRIMARY KEY(idPagamento),
    CONSTRAINT pagamento_cartao_fk
        FOREIGN KEY(idPagamento)
        REFERENCES pagamento(idPagamento)
        ON DELETE CASCADE,
    CONSTRAINT pagamento_cartao_tipo_check
        CHECK(tipoCartao IN ('CREDITO', 'DEBITO'))
);

CREATE TABLE pagamento_dinheiro (
    idPagamento INTEGER,
    valorRecebido DECIMAL(10,2) NOT NULL,
    troco DECIMAL(10,2) NOT NULL,
    observacao VARCHAR(255),
    CONSTRAINT pagamento_dinheiro_pk
        PRIMARY KEY(idPagamento),
    CONSTRAINT pagamento_dinheiro_fk
        FOREIGN KEY(idPagamento)
        REFERENCES pagamento(idPagamento)
        ON DELETE CASCADE,
    CONSTRAINT pagamento_dinheiro_valor_check
        CHECK(valorRecebido >=0),
    CONSTRAINT pagamento_dinheiro_troco_check
        CHECK(troco >=0)
);

CREATE TABLE pagamento_fiado (
    idPagamento INTEGER,
    dataVencimento DATE,
    dataPagamento TIMESTAMP,
    statusFiado VARCHAR(30) NOT NULL,
    observacao VARCHAR(255),
    CONSTRAINT pagamento_fiado_pk
        PRIMARY KEY(idPagamento),
    CONSTRAINT pagamento_fiado_fk
        FOREIGN KEY(idPagamento)
        REFERENCES pagamento(idPagamento)
        ON DELETE CASCADE,
    CONSTRAINT pagamento_fiado_status_check
        CHECK(statusFiado IN
        (
            'ABERTO',
            'PAGO',
            'ATRASADO'
        ))
);

CREATE TABLE entregador (
    idEntregador SERIAL,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL UNIQUE,
    status VARCHAR(30) NOT NULL DEFAULT 'DISPONIVEL',
    CONSTRAINT entregador_pk
        PRIMARY KEY(idEntregador),
    CONSTRAINT entregador_status_check
        CHECK(status IN
        (
            'DISPONIVEL',
            'INDISPONIVEL'
        ))
);

CREATE TABLE entrega (
    idEntrega SERIAL,
    taxaEntrega DECIMAL(10,2) NOT NULL,
    statusEntrega VARCHAR(30) NOT NULL,
    tempoEstimado INTEGER NOT NULL,
    horaSaida TIMESTAMP,
    horaEntrega TIMESTAMP,
    idPedido INTEGER NOT NULL UNIQUE,
    idEntregador INTEGER NOT NULL,
    CONSTRAINT entrega_pk
        PRIMARY KEY(idEntrega),
    CONSTRAINT entrega_pedido_fk
        FOREIGN KEY(idPedido)
        REFERENCES pedido(idPedido)
        ON UPDATE CASCADE,
    CONSTRAINT entrega_entregador_fk
        FOREIGN KEY(idEntregador)
        REFERENCES entregador(idEntregador)
        ON UPDATE CASCADE,
    CONSTRAINT entrega_taxa_check
        CHECK(taxaEntrega >=0),
    CONSTRAINT entrega_tempo_check
        CHECK(tempoEstimado >0),
    CONSTRAINT entrega_status_check
        CHECK(statusEntrega IN
        (
            'AGUARDANDO',
            'EM ROTA',
            'ENTREGUE',
            'CANCELADA'
        ))
);























