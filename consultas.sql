-- Consultas del informe (ejecutar después de InsercionDatos.sql)

USE banco_sangre;

-- Consulta 1
SELECT u.codigo_unidad, u.componente, u.fecha_caducidad
FROM UNIDAD_SANGRE u
WHERE u.estado = 'DISPONIBLE'
  AND u.fecha_caducidad BETWEEN '2026-11-09' AND '2026-12-09'
ORDER BY u.fecha_caducidad;

-- Consulta 2
SELECT u.codigo_unidad, t.grupo_abo, t.factor_rh, u.componente,
       u.fecha_caducidad
FROM PACIENTE p
JOIN COMPATIBILIDAD c ON c.id_tipo_receptor = p.id_tipo
JOIN UNIDAD_SANGRE u  ON u.id_tipo = c.id_tipo_donante
JOIN TIPO_SANGRE t    ON t.id_tipo = u.id_tipo
WHERE p.cedula_paciente = '1101000003'
  AND c.componente = 'CGR'
  AND u.componente = 'CGR'
  AND u.estado = 'DISPONIBLE'
ORDER BY u.fecha_caducidad;

-- Consulta 3
SELECT d.cedula, d.nombres, d.apellidos
FROM DONANTE d
WHERE d.cedula IN (SELECT f.cedula FROM FORMULARIO_DONACION f)
  AND d.cedula NOT IN (
        SELECT f.cedula
        FROM FORMULARIO_DONACION f
        JOIN EXAMEN_FISICO e      ON e.id_formulario = f.id_formulario
        JOIN ENTREVISTA_MEDICA i  ON i.id_examen = e.id_examen
        JOIN DONACION n           ON n.id_entrevista = i.id_entrevista)
ORDER BY d.cedula;

-- Consulta 4
SELECT n.id_donacion, n.fecha_hora
FROM DONACION n
WHERE NOT EXISTS (
        SELECT m.marcador
        FROM (SELECT DISTINCT marcador FROM PRUEBA_TAMIZAJE) m
        WHERE NOT EXISTS (
                SELECT 1
                FROM PRUEBA_TAMIZAJE p
                WHERE p.id_donacion = n.id_donacion
                  AND p.marcador = m.marcador))
ORDER BY n.id_donacion;

-- Consulta 5
SELECT t.grupo_abo, t.factor_rh,
       COUNT(u.codigo_unidad) AS unidades,
       SUM(u.volumen_ml)      AS volumen_total_ml
FROM UNIDAD_SANGRE u
JOIN TIPO_SANGRE t ON t.id_tipo = u.id_tipo
WHERE u.estado = 'DISPONIBLE'
GROUP BY t.grupo_abo, t.factor_rh
HAVING COUNT(u.codigo_unidad) >= 2
ORDER BY unidades DESC, t.grupo_abo;

