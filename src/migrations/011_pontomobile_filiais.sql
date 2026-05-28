USE ponto_web;

ALTER TABLE filiais
  ADD COLUMN pontomobile_id INT NULL AFTER ativa;
