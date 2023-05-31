--Apagar o banco de dados, o esquema e o usuário se existir, para que não haja problemas.
DROP DATABASE IF EXISTS uvv;
DROP SCHEMA IF EXISTS   lojas CASCADE;
DROP USER IF EXISTS     camila_domingos;

--Criação do usuário com permissão de criar banco de dados.
CREATE USER camila_domingos WITH
CREATEDB
CREATEROLE
ENCRYPTED PASSWORD 'camila';

--Comando para acessar o usuário "camila_domingos".
\c 'postgres://camila_domingos:camila@localhost/postgres';

--Comando para identificação do usuário.
SET ROLE camila_domingos; 

--Criação do Banco de Dados "uvv".
CREATE DATABASE uvv WITH
OWNER =             'camila_domingos'
TEMPLATE =          'template0'
ENCODING =          'UTF8'
LC_COLLATE =        'pt_BR.utf-8'
LC_CTYPE =          'pt_BR.utf-8'
ALLOW_CONNECTIONS = 'true';

COMMENT ON DATABASE uvv IS 'Criação do Banco de Dados uvv.';

--Comando para se conectar ao banco de dados com o usuário.
\c uvv
SET ROLE camila_domingos;

--Criação do esquema "lojas".
CREATE SCHEMA lojas
AUTHORIZATION camila_domingos;

--Comando para definição do esquema "lojas" como padrão.
SET SEARCH_PATH TO lojas, "$USER", PUBLIC;

--Comando para definição do esquema "lojas" como padrão definitivamente.
ALTER USER camila_domingos
SET SEARCH_PATH TO lojas, "$USER", PUBLIC;

--Tabelas que irão compor o Banco de Dados uvv.

--Criação da Tabela Produtos.
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

--Comentários referentes à Tabela Produtos e suas respectivas colunas.
COMMENT ON TABLE lojas.produtos IS 'Tabela com as informações dos produtos.';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Chave primária com o número de identificação dos produtos.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Nome de cada produto.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preço unitário de cada produto.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Detalhes do produto.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Coluna que identifica a forma como a imagem do produto foi armazenada (img., jpg., entre outros).';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Arquivo da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Codificação dos caracteres da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Data da última atualização da imagem do produto.';

--Criação da Tabela Lojas.
CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

--Comentários referentes à Tabela Lojas e suas respectivas colunas.
COMMENT ON TABLE lojas.lojas IS 'Tabela com as informações das lojas.';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Chave primária com o número de identificação de cada loja.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Nome de cada loja dentro de lojas uvv.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Endereço do site/web da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Endereço físico da loja (rua, bairro, número, cidade, etc).';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Latitude do endereço físico da loja.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Longitude do endereço físico da loja.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Imagem da logo.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Coluna que identifica a forma como a logo foi armazenada (img., jpg., entre outros).';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Arquivo da logo.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Codificação dos caracteres da logo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data da última atualização da logo.';

--Criação da Tabela Estoques.
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

--Comentários referentes à Tabela Estoques e suas respectivas colunas.
COMMENT ON TABLE lojas.estoques IS 'Tabela com as informações dos estoques.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Chave primária com o número de identificação do estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Chave estrangeira com o número de identificação da loja.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Chave estrangeira com o número de identificação dos produtos.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade atual de produtos em estoque.';

--Criação da Tabela Clientes.
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

--Comentários referentes à Tabela Clientes e suas respectivas colunas.
COMMENT ON TABLE lojas.clientes IS 'Tabela com as informações dos clientes das lojas uvv.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Chave primária com o número de identificação dos clientes.';
COMMENT ON COLUMN lojas.clientes.email IS 'Endereço de email de cada cliente.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Nome dos clientes.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Primeiro campo para telefone do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Segundo campo para telefone do cliente, se o mesmo quiser cadastrar outra opção.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Terceira opção de telefone do cliente, se necessário.';

--Criação da Tabela Envios.
CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

--Comentários referentes à Tabela Envios e suas respectivas colunas.
COMMENT ON TABLE lojas.envios IS 'Tabela com as informações dos envios.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Chave primária com o número de identificação dos envios.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Chave estrangeira com o número de identificação da loja.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Chave estrangeira com o número de identificação do cliente.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço de entrega para onde o produto será enviado.';
COMMENT ON COLUMN lojas.envios.status IS 'Estado dentro do processo de entrega em que o envio se encontra.';

--Criação da Tabela Pedidos.
CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

--Comentários referentes à Tabela Pedidos e suas respectivas colunas.
COMMENT ON TABLE lojas.pedidos IS 'Tabela com as informações de cada pedido feito pelos clientes.';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Chave primária com o número de identificação de cada pedido.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Coluna com horário e data que o pedido foi realizado.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Chave estrangeira com o número de identificação do cliente.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Estado do processo em que o pedido se encontra.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Chave estrangeira com o número de identificação da loja.';

--Criação da Tabela Pedidos Itens.
CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

--Comentários referentes à Tabela Pedidos Itens e suas respectivas colunas.
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela com as informações dos itens dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Chave primária-estrangeira com o número de identificação dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Chave primária-estrangeira com o número de identificação dos produtos.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Número da linha do item.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preço unitário dos itens.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade de itens no pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Chave estrangeira com o número de identificação do envio.';

--Criação de relacionamento não identificado entre as tabelas estoques e produtos.
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de relacionamento identificado entre as tabela pedidos_itens e produtos.
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de relacionamento não identificado entre as tabelas pedidos e lojas.
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de relacionamento não identificado entre as tabelas envios e lojas.
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de relacionamento não identificado entre as tabelas estoques e lojas.
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de relacionamento não identificado entre as tabelas pedidos e clientes.
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de relacionamento não identificado entre as tabelas envios e clientes.
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de relacionamento não identificado entre as tabelas pedidos_itens e envios.
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de relacionamento identificado entre as tabelas pedidos_itens e pedidos.
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--LISTA DAS CHECAGENS OBRIGATÓRIAS

/*Checagem da coluna status na tabela pedidos
para apenas permitir determinadas palavras.*/
ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedidos_status
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

/*Checagem da coluna status na tabela envios
para apenas permitir determinadas palavras.*/
ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_status
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

/*Checagem das colunas endereco_fisico e endereco_web
da tabela lojas para que pelo menos um esteja preenchido.*/
ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_lojas_endereco_fisico_endereco_web
CHECK ((endereco_fisico is not null OR endereco_web is not null));

/*Checagem da coluna quantidade da tabela pedidos_itens
para permitir apenas valores positivos.*/
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_quantidade
CHECK (quantidade >=0);

/*Checagem da coluna quantidade da tabela estoques
para permitir apenas valores positivos.*/
ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_estoques_quantidade
CHECK (quantidade >=0);


