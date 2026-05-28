-- Adiciona campos de endereço à tabela funcionarios
ALTER TABLE funcionarios
  ADD COLUMN cep         VARCHAR(9)   NULL AFTER pis,
  ADD COLUMN logradouro  VARCHAR(200) NULL AFTER cep,
  ADD COLUMN numero      VARCHAR(20)  NULL AFTER logradouro,
  ADD COLUMN complemento VARCHAR(100) NULL AFTER numero,
  ADD COLUMN bairro      VARCHAR(100) NULL AFTER complemento,
  ADD COLUMN cidade      VARCHAR(100) NULL AFTER bairro,
  ADD COLUMN estado      CHAR(2)      NULL AFTER cidade;
