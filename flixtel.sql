-- CRIANDO O BANCO
DROP DATABASE IF EXISTS flixtel_bd;
CREATE DATABASE flixtel_bd;
USE flixtel_bd;

SET SQL_SAFE_UPDATES = 0;

-- CRIANDO AS TABELAS
CREATE TABLE Usuario (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(45),
    email VARCHAR(45),
    senha CHAR(6),
    data_cadastro DATE
);

CREATE TABLE Assinaturas (
	id_assinatura INT PRIMARY KEY AUTO_INCREMENT,
    tipo_plano ENUM('Básico', 'Padrão', 'Premium'),
    valor_mensalidade DECIMAL(5,2),
    data_vencimento DATE,
    status_ativo BOOLEAN,
    id_usuario_assinatura INT,
    FOREIGN KEY (id_usuario_assinatura) REFERENCES Usuario (id_usuario)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Perfil (
	id_perfil INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    nome_perfil VARCHAR(45),
    classificacao_idade ENUM('L', '10', '12', '14', '15', '16', '18'),
    FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Filme (
	id_filme INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(60),
    duracao_minutos INT,
    ano_lancamento YEAR,
    sinopse TEXT
);

CREATE TABLE Historico_Assistido(
	ha_id_filme INT,
    ha_id_perfil INT,
    data_visualizacao DATE,
    PRIMARY KEY (ha_id_filme, ha_id_perfil),
    FOREIGN KEY (ha_id_filme) REFERENCES Filme (id_filme) ON DELETE CASCADE,
    FOREIGN KEY (ha_id_perfil) REFERENCES Perfil (id_perfil) ON DELETE CASCADE
);

CREATE TABLE Ator (
	id_ator INT PRIMARY KEY AUTO_INCREMENT,
    nome_artistico VARCHAR(45),
    nacionalidade VARCHAR(45),
    data_nascimento DATE
);

CREATE TABLE Elenco (
	elenco_id_ator INT,
    elenco_id_filme INT,
    nome_personagem VARCHAR(45),
    PRIMARY KEY (elenco_id_ator, elenco_id_filme),
    FOREIGN KEY (elenco_id_ator) REFERENCES Ator (id_ator) ON DELETE CASCADE,
    FOREIGN KEY (elenco_id_filme) REFERENCES Filme (id_filme) ON DELETE CASCADE
);

-- INSERINDO OS DADOS
INSERT INTO Usuario (nome_completo, email, senha, data_cadastro) VALUES
('Gabriel Fonseca', 'gf@gec.inatel.br', '123456', '2023-01-15'),
('Bruno Silva', 'bs@ges.inatel.br', 'qwerty', '2023-03-22'),
('Soned Redes', 'soned@inatel.br', 'soned1', '2023-06-10'),
('Renan Calculo', 'renan@inatel.br', 'aliens', '2023-09-05'),
('Jonas Dados', 'jonasdados@inatel.br', 'mysql1', '2024-01-02');

INSERT INTO Assinaturas (tipo_plano, valor_mensalidade, data_vencimento, status_ativo, id_usuario_assinatura) VALUES
('Premium', 59.90, '2024-12-15', TRUE, 1),
('Básico', 25.90, '2024-11-22', FALSE, 2),
('Padrão', 39.90, '2024-12-10', TRUE, 3),
('Premium', 59.90, '2024-12-05', TRUE, 4),
('Básico', 25.90, '2025-01-02', TRUE, 5);

INSERT INTO Perfil (id_usuario, nome_perfil, classificacao_idade) VALUES
(1, 'GabrielFF', '18'),
(2, 'BrunoS', '18'),
(3, 'ZezinhoFilho', 'L'),
(3, 'MariaFilho', '14'),
(4, 'Aliens1', '18'),
(4, 'MariaFilho', '16'),
(5, 'Eu', '18');

INSERT INTO Filme (titulo, duracao_minutos, ano_lancamento, sinopse) VALUES
('O Segredo do Vale', 120, '2022', 'Um detetive investiga um mistério em uma cidade pacata.'),
('Calculo I - O Retorno', 145, '2023', 'Um estudante tendo seus pesadelos em calculo I.'),
('WeekOne - A Festa', 95, '2021', 'Joãozinho entra na faculdade e se vê cercado de festas. Joãozinho vai para festas ou vai estudar?'),
('Chuveiro Queimado II - O Inimigo Agora é Outro', 105, '2020', 'Jovens de uma republica ficam horas tentando arrumar o chuveiro pela segunda vez.'),
('Calculo II - A Volta Dos Que Não Foram', 130, '2024', 'Depois de 3 semestres em calculo I, estudantes se encontram em uma nova aventura'),
('O Maior Trote', 150, '1999', 'A história de um grupo de estudantes que aplicou o maior trote da faculdade');

INSERT INTO Ator (nome_artistico, nacionalidade, data_nascimento) VALUES
('João Victor', 'Brasileiro', '1991-04-12'),
('Maria Clara', 'Portuguesa', '1996-08-25'),
('John Doe', 'Americano', '1998-11-03'),
('Laura Smith', 'Britânica', '1999-02-15'),
('Pedro Paulo', 'Brasileiro', '2000-05-30'),
('Maria José', 'Brasileira', '2001-12-02');

INSERT INTO Elenco (elenco_id_ator, elenco_id_filme, nome_personagem) VALUES
(1, 1, 'Detetive Marques'),
(3, 2, 'Enzo'),
(5, 3, 'O Nerd'),
(2, 5, 'Sobrevivente'),
(4, 6, 'Mestre do Crime');

INSERT INTO Historico_Assistido (ha_id_filme, ha_id_perfil, data_visualizacao) VALUES
(2, 1, '2024-10-01'),
(1, 2, '2024-10-15'),
(3, 2, '2024-10-20'),
(4, 1, '2024-11-02'),
(5, 5, '2024-11-08'),
(6, 4, '2025-01-03');

-- USANDO COMANDOS ALTER, UPDATE e DELETE
ALTER TABLE Filme ADD COLUMN classificacao_idade ENUM('L', '10', '12', '14', '15', '16', '18');

UPDATE Filme SET classificacao_idade = '14' WHERE id_filme = 1;
UPDATE Filme SET classificacao_idade = '18' WHERE id_filme = 2;
UPDATE Filme SET classificacao_idade = '16' WHERE id_filme = 3;
UPDATE Filme SET classificacao_idade = '12' WHERE id_filme = 4;
UPDATE Filme SET classificacao_idade = '18' WHERE id_filme = 5;
UPDATE Filme SET classificacao_idade = '14' WHERE id_filme = 6;

DELETE FROM Ator WHERE id_ator = 6;

-- USANDO SELECT
SELECT * FROM Usuario;
SELECT * FROM Filme;
SELECT * FROM Perfil;

SELECT titulo, sinopse FROM Filme;
SELECT nome_completo, data_cadastro FROM Usuario;

SELECT * FROM Elenco WHERE elenco_id_filme = 2;
SELECT * FROM Filme WHERE classificacao_idade = '14';

-- USANDO SELECT COM PEQUENAS FUNÇÕES
SELECT classificacao_idade, COUNT(*) AS total_de_perfis 
FROM Perfil 
GROUP BY classificacao_idade 
ORDER BY total_de_perfis DESC;

SELECT tipo_plano, SUM(valor_mensalidade) AS faturamento_total 
FROM Assinaturas 
GROUP BY tipo_plano 
ORDER BY faturamento_total ASC;

SELECT ano_lancamento, ROUND(AVG(duracao_minutos), 1) AS media_de_duracao
FROM Filme 
GROUP BY ano_lancamento 
ORDER BY media_de_duracao DESC;

SELECT classificacao_idade, MAX(duracao_minutos) AS filme_mais_longo, MIN(duracao_minutos) AS filme_mais_curto 
FROM Filme 
GROUP BY classificacao_idade 
ORDER BY classificacao_idade ASC;

SELECT ha_id_perfil AS id_do_perfil, COUNT(ha_id_filme) AS quantidade_filmes_assistidos 
FROM Historico_Assistido 
GROUP BY ha_id_perfil 
ORDER BY quantidade_filmes_assistidos DESC;

-- CRIANDO USUARIOS PRO BANCO
CREATE USER 'dev_Gabriel'@'host' IDENTIFIED BY 'senhaGabriel';
CREATE USER 'dev_Bruno'@'host' IDENTIFIED BY 'senhaBruno';

-- CRIANDO ROLE
DROP ROLE IF EXISTS 'dev_junior';
CREATE ROLE 'dev_junior';
GRANT SELECT, INSERT ON flixtel_bd.* TO 'dev_junior';
GRANT 'dev_junior' TO 'dev_Gabriel'@'host', 'dev_Bruno'@'host';

-- USANDO JOIN 
-- JOIN 1:1
SELECT u.nome_completo, u.email, a.tipo_plano, a.valor_mensalidade 
FROM Usuario u
INNER JOIN Assinaturas a ON u.id_usuario = a.id_usuario_assinatura;

-- JOIN 1:N
SELECT u.nome_completo AS dono_da_conta, p.nome_perfil, p.classificacao_idade 
FROM Usuario u
INNER JOIN Perfil p ON u.id_usuario = p.id_usuario
ORDER BY u.nome_completo;

-- JOIN N:M
SELECT p.nome_perfil, f.titulo AS filme_assistido, h.data_visualizacao 
FROM Perfil p
INNER JOIN Historico_Assistido h ON p.id_perfil = h.ha_id_perfil
INNER JOIN Filme f ON h.ha_id_filme = f.id_filme
ORDER BY h.data_visualizacao DESC;

-- CRIANDO VIEW
CREATE VIEW vw_catalogo_completo AS
SELECT f.titulo AS nome_filme, f.classificacao_idade, a.nome_artistico AS ator, e.nome_personagem AS personagem
FROM Filme f
INNER JOIN Elenco e ON f.id_filme = e.elenco_id_filme
INNER JOIN Ator a ON e.elenco_id_ator = a.id_ator;

SELECT * FROM vw_catalogo_completo;

-- CRIANDO FUNCTION
DELIMITER $$

CREATE FUNCTION fn_calcular_horas_filme(minutos INT) 
RETURNS DECIMAL(5,2) DETERMINISTIC
BEGIN
    DECLARE horas_decimais DECIMAL(5,2);
    
    SET horas_decimais = minutos / 60;
    
    RETURN horas_decimais;
END $$

DELIMITER ;
SELECT titulo, duracao_minutos, fn_calcular_horas_filme(duracao_minutos) AS duracao_em_horas FROM Filme;

-- CRIANDO PROCEDURE
DELIMITER $$

CREATE PROCEDURE sp_mudar_plano(IN p_id_assinatura INT, IN p_novo_plano ENUM('Básico', 'Padrão', 'Premium'))
BEGIN
    DECLARE v_novo_valor DECIMAL(5,2);
    
    IF p_novo_plano = 'Básico' THEN
        SET v_novo_valor = 25.90;
    ELSEIF p_novo_plano = 'Padrão' THEN
        SET v_novo_valor = 39.90;
    ELSEIF p_novo_plano = 'Premium' THEN
        SET v_novo_valor = 59.90;
    END IF;
    
    UPDATE Assinaturas 
    SET tipo_plano = p_novo_plano, 
        valor_mensalidade = v_novo_valor
    WHERE id_assinatura = p_id_assinatura;
    
    -- Retorna os dados em colunas separadas em vez de uma frase de texto
    SELECT p_id_assinatura AS ID_Atualizado, p_novo_plano AS Plano_Escolhido, v_novo_valor AS Novo_Valor_Cobrado;
    
END $$

DELIMITER ;
CALL sp_mudar_plano(2, 'Premium');

-- CRIANDO TRIGGER
DELIMITER $$

CREATE TRIGGER tr_criar_perfil_padrao
AFTER INSERT ON Usuario
FOR EACH ROW
BEGIN
    -- O 'NEW.id_usuario' pega o ID do usuário que acabou de ser inserido
    INSERT INTO Perfil (id_usuario, nome_perfil, classificacao_idade)
    VALUES (NEW.id_usuario, 'Meu Perfil', '18');
END $$

DELIMITER ;
INSERT INTO Usuario (nome_completo, email, senha, data_cadastro) VALUES
('Renzo Coodernador', 'renzo@inatel.br', 'kahoot', '2025-03-12');

-- LIMPEZA DOS VIEW TRIGGER PROCEDURE E FUNCTION
DROP VIEW IF EXISTS vw_catalogo_completo;
DROP TRIGGER IF EXISTS tr_criar_perfil_padrao;
DROP PROCEDURE IF EXISTS sp_mudar_plano;
DROP FUNCTION IF EXISTS fn_calcular_horas_filme;