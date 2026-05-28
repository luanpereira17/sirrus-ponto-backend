-- ─── Migration 018: audit_log — rastreabilidade Portaria 671/2021 ────────────
-- UP

USE ponto_web;

CREATE TABLE IF NOT EXISTS audit_log (
  id            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  usuario_id    INT NULL
    COMMENT 'funcionarios.id do usuário que executou a ação (NULL = sistema)',
  acao          VARCHAR(20) NOT NULL
    COMMENT 'INSERT | UPDATE | DELETE',
  tabela        VARCHAR(60) NOT NULL,
  registro_id   INT NOT NULL
    COMMENT 'PK do registro afetado na tabela alvo',
  dados_anteriores JSON NULL
    COMMENT 'Estado antes da mudança (NULL em INSERT)',
  dados_novos   JSON NULL
    COMMENT 'Estado após a mudança (NULL em DELETE)',
  ip_address    VARCHAR(45) NULL,
  created_at    DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  INDEX idx_audit_tabela_registro (tabela, registro_id),
  INDEX idx_audit_usuario (usuario_id),
  INDEX idx_audit_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Trilha de auditoria — Portaria 671/2021';

-- ─── DOWN ────────────────────────────────────────────────────────────────────
-- DROP TABLE IF EXISTS audit_log;
