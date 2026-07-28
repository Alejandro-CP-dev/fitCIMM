-- 1. Listar cada socio con la fecha de fin de su membresía más reciente y los días que le restan.

SELECT 
    s.documento,
    CONCAT(s.nombres, ' ', s.apellidos) AS socio,
    p.nombre AS plan,
    MAX(m.fecha_fin) AS ultima_fecha_fin,
    DATEDIFF(MAX(m.fecha_fin), CURDATE()) AS dias_restantes 
FROM socio s
INNER JOIN membresia m ON s.id_socio = m.id_socio
INNER JOIN plan p ON m.id_plan = p.id_plan
GROUP BY s.id_socio, s.documento, s.nombres, s.apellidos, p.nombre
ORDER BY ultima_fecha_fin DESC;

-- 2. Obtener el total recaudado por plan en un rango de fechas, ordenado de mayor a menor.

SELECT 
    p.nombre AS plan,
    COUNT(m.id_membresia) AS total_ventas,
    SUM(m.valor_pagado) AS total_recaudado
FROM membresia m
INNER JOIN plan p ON m.id_plan = p.id_plan
WHERE m.fecha_inicio BETWEEN ? AND ?
GROUP BY p.id_plan, p.nombre
ORDER BY total_recaudado DESC;

-- 3. Identificar los socios cuya membresía vence dentro de los próximos 5 días.
SELECT 
    s.documento,
    CONCAT(s.nombres, ' ', s.apellidos) AS socio,
    s.telefono,
    p.nombre AS plan,
    m.fecha_fin,
    DATEDIFF(m.fecha_fin, CURDATE()) AS dias_restantes
FROM socio s
INNER JOIN membresia m ON s.id_socio = m.id_socio
INNER JOIN plan p ON m.id_plan = p.id_plan
WHERE s.activo = TRUE 
  AND m.fecha_fin BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 5 DAY)
ORDER BY m.fecha_fin ASC;

-- 4. Contar cuántos ingresos se registraron por día durante la última semana (últimos 7 días).
SELECT 
    DATE(i.fecha_hora) AS fecha_ingreso,
    DAYNAME(i.fecha_hora) AS dia_semana,
    COUNT(i.id_ingreso) AS total_ingresos
FROM ingreso i
WHERE i.fecha_hora >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY DATE(i.fecha_hora), DAYNAME(i.fecha_hora)
ORDER BY fecha_ingreso DESC;

-- 5. Encontrar los socios activos que nunca han registrado un ingreso.
SELECT 
    s.id_socio,
    s.documento,
    CONCAT(s.nombres, ' ', s.apellidos) AS socio,
    s.telefono,
    s.email
FROM socio s
LEFT JOIN ingreso i ON s.id_socio = i.id_socio
WHERE s.activo = TRUE 
  AND i.id_ingreso IS NULL;