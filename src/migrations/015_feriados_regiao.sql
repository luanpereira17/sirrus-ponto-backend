-- ─── Migration 015: feriados — suporte a feriados estaduais e municipais ────────
-- UP

USE ponto_web;

-- Adiciona colunas de região (opcionais — NULL = aplica a todos)
ALTER TABLE feriados
  ADD COLUMN uf VARCHAR(2) NULL
    COMMENT 'UF do feriado estadual/municipal (NULL = nacional ou empresa)'
  AFTER tipo,
  ADD COLUMN municipio_ibge VARCHAR(7) NULL
    COMMENT 'Código IBGE do município para feriados municipais (NULL = não municipal)'
  AFTER uf;

-- Remove unique key antiga que impedia múltiplos feriados na mesma data (de regiões diferentes).
ALTER TABLE feriados DROP FOREIGN KEY fk_feriado_empresa;
ALTER TABLE feriados DROP INDEX uk_feriado_empresa_data;
ALTER TABLE feriados
  ADD CONSTRAINT fk_feriado_empresa
    FOREIGN KEY (empresa_id) REFERENCES empresas(id) ON DELETE CASCADE;

-- Nova unique key que permite feriados diferentes por região na mesma data
ALTER TABLE feriados
  ADD UNIQUE KEY uk_feriado_empresa_data_regiao (empresa_id, data, uf, municipio_ibge);

-- ─── DOWN ────────────────────────────────────────────────────────────────────
-- Para reverter:
--
-- ALTER TABLE feriados DROP INDEX uk_feriado_empresa_data_regiao;
-- ALTER TABLE feriados ADD UNIQUE KEY uk_feriado_empresa_data (empresa_id, data);
-- ALTER TABLE feriados DROP COLUMN municipio_ibge;
-- ALTER TABLE feriados DROP COLUMN uf;
