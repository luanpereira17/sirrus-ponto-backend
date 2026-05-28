import { query } from '../config/database.js';

function pad2(n) {
  return String(n).padStart(2, '0');
}

export const FeriadoRepository = {
  /** Feriados da empresa entre o primeiro e o último dia do mês (inclusive). */
  async listByEmpresaMonth(empresaId, year, month) {
    const start = `${year}-${pad2(month)}-01`;
    const lastDay = new Date(year, month, 0).getDate();
    const end = `${year}-${pad2(month)}-${pad2(lastDay)}`;
    const monthPad = pad2(month);

    return query(
      `SELECT
         IF(recorrente = 1,
           CONCAT(?, '-', DATE_FORMAT(data, '%m-%d')),
           DATE_FORMAT(data, '%Y-%m-%d')
         ) AS dia,
         descricao, tipo, uf, municipio_ibge
       FROM feriados
       WHERE empresa_id = ?
         AND (
           (recorrente = 0 AND data >= ? AND data <= ?)
           OR
           (recorrente = 1 AND DATE_FORMAT(data, '%m') = ?)
         )
       ORDER BY dia`,
      [year, empresaId, start, end, monthPad],
    );
  },
};
