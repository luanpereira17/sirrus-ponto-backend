-- Vincula funcionário a um município cadastrado para fuso horário
ALTER TABLE funcionarios
  ADD COLUMN municipio_id INT UNSIGNED NULL AFTER estado;

-- Índice para agilizar o JOIN com municipios
ALTER TABLE funcionarios
  ADD INDEX idx_func_municipio (municipio_id);
