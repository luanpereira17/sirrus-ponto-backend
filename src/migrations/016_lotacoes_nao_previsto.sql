-- ─── Migration 016: lotacoes — colunas de adicional para dias não previstos ────
-- UP

USE ponto_web;

-- Adicional para domingo trabalhado sem escala/turno prevendo esse dia
-- Default '100pct_total': CLT padrão — domingo não previsto = 100% sobre tudo trabalhado
ALTER TABLE lotacoes
  ADD COLUMN domingo_nao_previsto_tipo
    ENUM('nao_calcular', '50pct', '100pct_total', 'igual_feriado')
    NOT NULL DEFAULT '100pct_total'
    COMMENT 'Regra de adicional quando funcionário trabalha em domingo não previsto na escala/turno'
  AFTER domingo_tipo;

-- Adicional para dia útil trabalhado sem escala/turno prevendo esse dia
-- Default 'nao_calcular': conservador — dia útil não previsto não gera adicional automático
ALTER TABLE lotacoes
  ADD COLUMN dia_nao_previsto_tipo
    ENUM('nao_calcular', '50pct', '100pct_total', 'igual_domingo')
    NOT NULL DEFAULT 'nao_calcular'
    COMMENT 'Regra de adicional quando funcionário trabalha em dia útil não previsto na escala/turno'
  AFTER domingo_nao_previsto_tipo;

-- ─── DOWN ────────────────────────────────────────────────────────────────────
-- Para reverter:
--
-- ALTER TABLE lotacoes DROP COLUMN IF EXISTS dia_nao_previsto_tipo;
-- ALTER TABLE lotacoes DROP COLUMN IF EXISTS domingo_nao_previsto_tipo;
