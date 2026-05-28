-- ─── Migration 017: cartao_ponto — documentar uso futuro ────────────────────
-- UP

USE ponto_web;

-- Tabela reservada para lock de fechamento de período e snapshot assinado de espelho.
-- Não usar ainda — implementação prevista como backlog item #1 (alta prioridade).
-- Contexto: após o primeiro fechamento real de folha (julho/2026), esta tabela armazenará
-- o espelho calculado e congelado por período, impedindo recálculo retroativo após fechamento.
ALTER TABLE cartao_ponto
  COMMENT = 'Reservada para uso futuro: lock de fechamento de período e snapshot assinado de espelho de ponto. Não popular diretamente até implementação do mecanismo de lock (backlog #1).';

-- ─── DOWN ────────────────────────────────────────────────────────────────────
-- Para reverter (remove o comentário):
--
-- ALTER TABLE cartao_ponto COMMENT = '';
