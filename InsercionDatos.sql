-- Banco de Sangre (Loja, Ecuador) - Inserción de datos (DML)
-- Ejecutar después de codigo.sql. Datos de prueba ficticios.

USE banco_sangre;

INSERT INTO TIPO_SANGRE (id_tipo, grupo_abo, factor_rh) VALUES
    (1, 'O', '+'),
    (2, 'O', '-'),
    (3, 'A', '+'),
    (4, 'A', '-'),
    (5, 'B', '+'),
    (6, 'B', '-'),
    (7, 'AB', '+'),
    (8, 'AB', '-');

-- Compatibilidad de glóbulos rojos (CGR): donante -> receptor
INSERT INTO COMPATIBILIDAD (id_tipo_donante, id_tipo_receptor, componente) VALUES
    (1,1,'CGR'), (1,3,'CGR'), (1,5,'CGR'), (1,7,'CGR'), (2,1,'CGR'),
    (2,2,'CGR'), (2,3,'CGR'), (2,4,'CGR'), (2,5,'CGR'), (2,6,'CGR'),
    (2,7,'CGR'), (2,8,'CGR'), (3,3,'CGR'), (3,7,'CGR'), (4,3,'CGR'),
    (4,4,'CGR'), (4,7,'CGR'), (4,8,'CGR'), (5,5,'CGR'), (5,7,'CGR'),
    (6,5,'CGR'), (6,6,'CGR'), (6,7,'CGR'), (6,8,'CGR'), (7,7,'CGR'),
    (8,7,'CGR'), (8,8,'CGR');

INSERT INTO BANCO_SANGRE (id_banco, nombre, tipo_establecimiento, provincia,
                          canton, direccion) VALUES
    (1, 'Cruz Roja Ecuatoriana - Junta Provincial de Loja',
        'Banco de sangre', 'Loja', 'Loja', 'Loja (dato de prueba)'),
    (2, 'Servicio de Medicina Transfusional - Hospital General Isidro Ayora',
        'Servicio de medicina transfusional', 'Loja', 'Loja',
        'Loja (dato de prueba)');

INSERT INTO HOSPITAL (id_establecimiento, nombre, tipo, canton,
                      codigo_msp) VALUES
    (1, 'Hospital General Isidro Ayora', 'Hospital general', 'Loja', 'MSP-0001'),
    (2, 'Hospital Basico de Catamayo'  , 'Hospital basico' , 'Catamayo',
        'MSP-0002');

INSERT INTO PERSONAL_SALUD (id_personal, nombres, cargo, registro_profesional,
                            institucion) VALUES
    (1, 'Maria Elena Ortiz'   , 'MEDICO'     , 'REG-1001',
        'Cruz Roja Ecuatoriana - Loja'),
    (2, 'Carlos Andrade'      , 'ENFERMERIA' , 'REG-1002',
        'Cruz Roja Ecuatoriana - Loja'),
    (3, 'Luis Romero'         , 'MEDICO'     , 'REG-1003',
        'Hospital General Isidro Ayora'),
    (4, 'Patricia Jaramillo'  , 'ENFERMERIA' , 'REG-1004',
        'Hospital General Isidro Ayora');

-- Datos ficticios: las cedulas y los nombres no corresponden a personas reales
INSERT INTO DONANTE (cedula, nombres, apellidos, fecha_nacimiento, sexo,
                     telefono, canton_residencia, ocupacion,
                     fecha_ultima_donacion, id_tipo) VALUES
    ('1100000001', 'Juan Carlos' , 'Armijos Leon'  , '1998-03-14', 'M',
     '0990000001', 'Loja'    , 'Estudiante'  , '2026-10-20', 1),
    ('1100000002', 'Luisa Fernanda', 'Castillo Pardo', '1995-07-02', 'F',
     '0990000002', 'Loja'    , 'Docente'     , '2026-09-12', 3),
    ('1100000003', 'Diego Paul'  , 'Jimenez Torres', '1990-11-23', 'M',
     '0990000003', 'Catamayo', 'Comerciante' , '2026-10-05', 2),
    ('1100000004', 'Marco Antonio', 'Vega Salinas' , '1988-01-30', 'M',
     '0990000004', 'Loja'    , 'Ingeniero'   , '2026-10-27', 5),
    ('1100000005', 'Ana Belen'   , 'Ruiz Cueva'    , '2000-05-19', 'F',
     '0990000005', 'Loja'    , 'Estudiante'  , NULL        , 6),
    ('1100000006', 'Karla Dayana', 'Sarango Pineda', '1999-09-08', 'F',
     '0990000006', 'Saraguro', 'Estudiante'  , NULL        , 8),
    ('1100000007', 'Jose Luis'   , 'Tapia Merino'  , '1993-12-11', 'M',
     '0990000007', 'Loja'    , 'Contador'    , '2026-11-03', 4),
    ('1100000008', 'Gabriela Alexandra', 'Ochoa Rivera', '1997-04-25', 'F',
     '0990000008', 'Loja'    , 'Enfermera'   , NULL        , 1);

INSERT INTO FORMULARIO_DONACION (id_formulario, cedula, fecha, consentimiento,
        tatuaje_reciente, viaje_reciente, medicamentos, enfermedades,
        conducta_riesgo, embarazo_lactancia, resultado) VALUES
    (1, '1100000001', '2026-06-15', 'SI', 'NO', 'NO', NULL, NULL, 'NO', 'NO', 'APTO'),
    (2, '1100000002', '2026-09-12', 'SI', 'NO', 'NO', NULL, NULL, 'NO', 'NO', 'APTO'),
    (3, '1100000003', '2026-10-05', 'SI', 'NO', 'NO', NULL, NULL, 'NO', 'NO', 'APTO'),
    (4, '1100000001', '2026-10-20', 'SI', 'NO', 'NO', NULL, NULL, 'NO', 'NO', 'APTO'),
    (5, '1100000004', '2026-10-27', 'SI', 'NO', 'NO', NULL, NULL, 'NO', 'NO', 'APTO'),
    (6, '1100000007', '2026-11-03', 'SI', 'NO', 'NO', NULL, NULL, 'NO', 'NO', 'APTO'),
    (7, '1100000005', '2026-11-04', 'SI', 'NO', 'NO', NULL, NULL, 'NO', 'NO', 'APTO'),
    (8, '1100000006', '2026-11-05', 'SI', 'SI', 'NO', NULL, NULL, 'NO', 'NO', 'NO_APTO'),
    (9, '1100000008', '2026-11-06', 'SI', 'NO', 'NO', NULL, NULL, 'NO', 'NO', 'APTO');

INSERT INTO EXAMEN_FISICO (id_examen, id_formulario, peso_kg, talla_cm,
        presion_arterial, pulso, temperatura, hemoglobina, resultado) VALUES
    (1, 1, 72.5, 175.0, '120/80', 72, 36.5, 15.2, 'APTO'),
    (2, 2, 61.0, 162.0, '110/70', 76, 36.6, 13.8, 'APTO'),
    (3, 3, 80.2, 178.0, '125/80', 70, 36.4, 15.0, 'APTO'),
    (4, 4, 72.8, 175.0, '118/78', 74, 36.5, 15.1, 'APTO'),
    (5, 5, 85.0, 180.0, '122/82', 68, 36.7, 15.6, 'APTO'),
    (6, 6, 77.4, 173.0, '115/75', 71, 36.5, 14.9, 'APTO'),
    (7, 7, 55.0, 158.0, '105/68', 80, 36.6, 11.2, 'NO_APTO'),
    (8, 9, 58.5, 160.0, '108/70', 75, 36.5, 13.5, 'APTO');

INSERT INTO ENTREVISTA_MEDICA (id_entrevista, id_examen, id_personal, fecha,
        observaciones, decision, motivo_diferimiento,
        fecha_fin_diferimiento) VALUES
    (1, 1, 1, '2026-06-15', 'Sin hallazgos', 'APTO'    , NULL, NULL),
    (2, 2, 1, '2026-09-12', 'Sin hallazgos', 'APTO'    , NULL, NULL),
    (3, 3, 1, '2026-10-05', 'Sin hallazgos', 'APTO'    , NULL, NULL),
    (4, 4, 1, '2026-10-20', 'Sin hallazgos', 'APTO'    , NULL, NULL),
    (5, 5, 3, '2026-10-27', 'Sin hallazgos', 'APTO'    , NULL, NULL),
    (6, 6, 3, '2026-11-03', 'Sin hallazgos', 'APTO'    , NULL, NULL),
    (7, 7, 1, '2026-11-04', 'Hemoglobina por debajo del minimo', 'DIFERIDO',
        'Hemoglobina baja', '2027-02-04'),
    (8, 8, 1, '2026-11-06', 'Apto; donacion pendiente de agendar', 'APTO',
        NULL, NULL);

INSERT INTO DONACION (id_donacion, id_entrevista, id_personal, id_banco,
        fecha_hora, tipo_donacion, volumen_ml, reaccion_adversa, estado) VALUES
    (1, 1, 2, 1, '2026-06-15 08:40:00', 'SANGRE_TOTAL', 450, 'NINGUNA', 'COMPLETA'),
    (2, 2, 2, 1, '2026-09-12 09:15:00', 'SANGRE_TOTAL', 450, 'NINGUNA', 'COMPLETA'),
    (3, 3, 2, 1, '2026-10-05 10:05:00', 'SANGRE_TOTAL', 450, 'NINGUNA', 'COMPLETA'),
    (4, 4, 2, 1, '2026-10-20 08:30:00', 'SANGRE_TOTAL', 450, 'NINGUNA', 'COMPLETA'),
    (5, 5, 4, 2, '2026-10-27 11:00:00', 'SANGRE_TOTAL', 450, 'MAREO LEVE', 'COMPLETA'),
    (6, 6, 4, 2, '2026-11-03 09:45:00', 'SANGRE_TOTAL', 450, 'NINGUNA', 'COMPLETA');

INSERT INTO UNIDAD_SANGRE (codigo_unidad, id_donacion, id_tipo, componente,
        volumen_ml, fecha_extraccion, fecha_caducidad, estado,
        temperatura_almac, numero_lote) VALUES
    ('UN-2026-001', 1, 1, 'CGR'   , 280, '2026-06-15', '2026-07-27', 'CADUCADA'  , '2-6 C'  ,
      'L-0615'),
    ('UN-2026-002', 1, 1, 'PLASMA', 200, '2026-06-15', '2027-06-15', 'DISPONIBLE', '-30 C'  ,
      'L-0615'),
    ('UN-2026-003', 2, 3, 'CGR'   , 280, '2026-09-12', '2026-10-24', 'TRANSFUNDIDA', '2-6 C',
      'L-0912'),
    ('UN-2026-004', 2, 3, 'PLASMA', 200, '2026-09-12', '2027-09-12', 'DISPONIBLE', '-30 C'  ,
      'L-0912'),
    ('UN-2026-005', 3, 2, 'CGR'   , 280, '2026-10-05', '2026-11-16', 'DESCARTADA', '2-6 C'  ,
      'L-1005'),
    ('UN-2026-006', 3, 2, 'PLASMA', 200, '2026-10-05', '2027-10-05', 'DESCARTADA', '-30 C'  ,
      'L-1005'),
    ('UN-2026-007', 4, 1, 'CGR'   , 280, '2026-10-20', '2026-12-01', 'DISPONIBLE', '2-6 C'  ,
      'L-1020'),
    ('UN-2026-008', 4, 1, 'PLASMA', 200, '2026-10-20', '2027-10-20', 'DISPONIBLE', '-30 C'  ,
      'L-1020'),
    ('UN-2026-009', 5, 5, 'CGR'   , 280, '2026-10-27', '2026-12-08', 'DISPONIBLE', '2-6 C'  ,
      'L-1027'),
    ('UN-2026-010', 5, 5, 'PLASMA', 200, '2026-10-27', '2027-10-27', 'DISPONIBLE', '-30 C'  ,
      'L-1027'),
    ('UN-2026-011', 6, 4, 'CGR'   , 280, '2026-11-03', '2026-12-15', 'CUARENTENA', '2-6 C'  ,
      'L-1103'),
    ('UN-2026-012', 6, 4, 'PLASMA', 200, '2026-11-03', '2027-11-03', 'CUARENTENA', '-30 C'  ,
      'L-1103');

INSERT INTO PRUEBA_TAMIZAJE (id_donacion, marcador, fecha, metodo,
                            resultado, lote_reactivo) VALUES
    (1, 'VIH', '2026-06-16', 'ELISA', 'NO_REACTIVO', 'LR-2026-01'),
    (1, 'HEPATITIS_B', '2026-06-16', 'ELISA', 'NO_REACTIVO', 'LR-2026-01'),
    (1, 'HEPATITIS_C', '2026-06-16', 'ELISA', 'NO_REACTIVO', 'LR-2026-01'),
    (1, 'SIFILIS', '2026-06-16', 'ELISA', 'NO_REACTIVO', 'LR-2026-01'),
    (1, 'CHAGAS', '2026-06-16', 'ELISA', 'NO_REACTIVO', 'LR-2026-01'),
    (1, 'HTLV', '2026-06-16', 'ELISA', 'NO_REACTIVO', 'LR-2026-01'),
    (2, 'VIH', '2026-09-13', 'ELISA', 'NO_REACTIVO', 'LR-2026-02'),
    (2, 'HEPATITIS_B', '2026-09-13', 'ELISA', 'NO_REACTIVO', 'LR-2026-02'),
    (2, 'HEPATITIS_C', '2026-09-13', 'ELISA', 'NO_REACTIVO', 'LR-2026-02'),
    (2, 'SIFILIS', '2026-09-13', 'ELISA', 'NO_REACTIVO', 'LR-2026-02'),
    (2, 'CHAGAS', '2026-09-13', 'ELISA', 'NO_REACTIVO', 'LR-2026-02'),
    (2, 'HTLV', '2026-09-13', 'ELISA', 'NO_REACTIVO', 'LR-2026-02'),
    (3, 'VIH', '2026-10-06', 'ELISA', 'NO_REACTIVO', 'LR-2026-03'),
    (3, 'HEPATITIS_B', '2026-10-06', 'ELISA', 'NO_REACTIVO', 'LR-2026-03'),
    (3, 'HEPATITIS_C', '2026-10-06', 'ELISA', 'NO_REACTIVO', 'LR-2026-03'),
    (3, 'SIFILIS', '2026-10-06', 'ELISA', 'NO_REACTIVO', 'LR-2026-03'),
    (3, 'CHAGAS', '2026-10-06', 'ELISA', 'REACTIVO', 'LR-2026-03'),
    (3, 'HTLV', '2026-10-06', 'ELISA', 'NO_REACTIVO', 'LR-2026-03'),
    (4, 'VIH', '2026-10-21', 'ELISA', 'NO_REACTIVO', 'LR-2026-04'),
    (4, 'HEPATITIS_B', '2026-10-21', 'ELISA', 'NO_REACTIVO', 'LR-2026-04'),
    (4, 'HEPATITIS_C', '2026-10-21', 'ELISA', 'NO_REACTIVO', 'LR-2026-04'),
    (4, 'SIFILIS', '2026-10-21', 'ELISA', 'NO_REACTIVO', 'LR-2026-04'),
    (4, 'CHAGAS', '2026-10-21', 'ELISA', 'NO_REACTIVO', 'LR-2026-04'),
    (4, 'HTLV', '2026-10-21', 'ELISA', 'NO_REACTIVO', 'LR-2026-04'),
    (5, 'VIH', '2026-10-28', 'ELISA', 'NO_REACTIVO', 'LR-2026-05'),
    (5, 'HEPATITIS_B', '2026-10-28', 'ELISA', 'NO_REACTIVO', 'LR-2026-05'),
    (5, 'HEPATITIS_C', '2026-10-28', 'ELISA', 'NO_REACTIVO', 'LR-2026-05'),
    (5, 'SIFILIS', '2026-10-28', 'ELISA', 'NO_REACTIVO', 'LR-2026-05'),
    (5, 'CHAGAS', '2026-10-28', 'ELISA', 'NO_REACTIVO', 'LR-2026-05'),
    (5, 'HTLV', '2026-10-28', 'ELISA', 'NO_REACTIVO', 'LR-2026-05'),
    (6, 'VIH', '2026-11-04', 'ELISA', 'NO_REACTIVO', 'LR-2026-06'),
    (6, 'HEPATITIS_B', '2026-11-04', 'ELISA', 'NO_REACTIVO', 'LR-2026-06'),
    (6, 'HEPATITIS_C', '2026-11-04', 'ELISA', 'NO_REACTIVO', 'LR-2026-06'),
    (6, 'SIFILIS', '2026-11-04', 'ELISA', 'NO_REACTIVO', 'LR-2026-06'),
    (6, 'CHAGAS', '2026-11-04', 'ELISA', 'NO_REACTIVO', 'LR-2026-06');

INSERT INTO PACIENTE (cedula_paciente, id_tipo, nombres, apellidos,
                      fecha_nacimiento, historia_clinica, diagnostico) VALUES
    ('1101000001', 1, 'Rosa Maria'  , 'Gonzalez Mora' , '1960-02-10', 'HC-5001',
      'Anemia severa'),
    ('1101000002', 3, 'Pedro Pablo' , 'Cabrera Sanchez', '1975-08-21', 'HC-5002',
      'Hemorragia digestiva'),
    ('1101000003', 5, 'Mariana'     , 'Quezada Lopez' , '1988-06-17', 'HC-5003',
      'Cirugia programada'),
    ('1101000004', 7, 'Segundo Luis', 'Poma Castro'   , '1950-12-02', 'HC-5004',
      'Anemia cronica');

INSERT INTO SOLICITUD_TRANSFUSION (id_solicitud, cedula_paciente,
        id_establecimiento, fecha_solicitud, componente, cantidad_unidades,
        urgencia, diagnostico, estado, medico_solicitante) VALUES
    (1, '1101000002', 1, '2026-09-20', 'CGR', 1, 'URGENTE' , 'Hemorragia digestiva',
      'ATENDIDA' , 'Dr. Andres Paredes'),
    (2, '1101000003', 2, '2026-11-05', 'CGR', 2, 'RUTINA'  , 'Cirugia programada'  ,
      'PENDIENTE', 'Dra. Sofia Barba'),
    (3, '1101000001', 1, '2026-11-07', 'CGR', 1, 'URGENTE' , 'Anemia severa'      ,
      'PENDIENTE', 'Dr. Andres Paredes');

INSERT INTO ASIGNACION (codigo_unidad, id_solicitud, fecha_entrega,
                        prueba_cruzada, resultado_compat) VALUES
    ('UN-2026-003', 1, '2026-09-20', 'SI', 'COMPATIBLE');

INSERT INTO MOVIMIENTO_UNIDAD (codigo_unidad, fecha_hora, tipo_movimiento,
        ubicacion_origen, ubicacion_destino, responsable, observacion) VALUES
    ('UN-2026-003', '2026-09-12 10:30:00', 'INGRESO'       , 'Sala de donacion',
      'Cuarentena'         , 'Carlos Andrade', NULL),
    ('UN-2026-003', '2026-09-14 08:00:00', 'ALMACENAMIENTO', 'Cuarentena'      ,
      'Refrigerador 1'     , 'Carlos Andrade', 'Tamizaje no reactivo'),
    ('UN-2026-003', '2026-09-20 15:10:00', 'DESPACHO'      , 'Refrigerador 1'  ,
      'Hospital General Isidro Ayora', 'Carlos Andrade', 'Solicitud 1'),
    ('UN-2026-003', '2026-09-20 17:00:00', 'TRANSFUSION'   , 'Hospital General Isidro Ayora',
      'Paciente', 'Dr. Andres Paredes', NULL),
    ('UN-2026-005', '2026-10-05 11:00:00', 'INGRESO'       , 'Sala de donacion',
      'Cuarentena'         , 'Carlos Andrade', NULL),
    ('UN-2026-005', '2026-10-08 09:00:00', 'DESCARTE'      , 'Cuarentena'      ,
      NULL                 , 'Maria Elena Ortiz', 'Chagas reactivo'),
    ('UN-2026-007', '2026-10-20 09:30:00', 'INGRESO'       , 'Sala de donacion',
      'Cuarentena'         , 'Carlos Andrade', NULL),
    ('UN-2026-007', '2026-10-22 08:00:00', 'ALMACENAMIENTO', 'Cuarentena'      ,
      'Refrigerador 1'     , 'Carlos Andrade', 'Tamizaje no reactivo'),
    ('UN-2026-009', '2026-10-27 12:00:00', 'INGRESO'       , 'Sala de donacion',
      'Cuarentena'         , 'Patricia Jaramillo', NULL),
    ('UN-2026-009', '2026-10-29 08:00:00', 'ALMACENAMIENTO', 'Cuarentena'      ,
      'Refrigerador 2'     , 'Patricia Jaramillo', 'Tamizaje no reactivo');
