/*
Nombre del archivo: dating.sql
Propósito: Base de datos para un sitio de citas.
Autor: Miguel Gonzalez
Fecha de creación: 2022-12-30

mensajes
bloqueos
notificaciones_push
conversaciones
favoritos

*/

-- Crear la base de datos
CREATE DATABASE dating;

-- Usar la base de datos
USE dating;

-- 1.- Estructura de la tabla `usuarios`

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `genero` enum('hombre','mujer','otro') NOT NULL,
  `preferencia_genero` enum('hombre','mujer','otro') NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  `pais` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `foto_perfil` varchar(255) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 2.- Estructura de la tabla `intereses`

CREATE TABLE `intereses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interes` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 3.- Estructura de la tabla `usuarios_intereses`

CREATE TABLE `usuarios_intereses` (
  `id_usuario` int(11) NOT NULL,
  `id_interes` int(11) NOT NULL,
  KEY `id_usuario` (`id_usuario`),
  KEY `id_interes` (`id_interes`),
  CONSTRAINT `usuarios_intereses_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usuarios_intereses_ibfk_2` FOREIGN KEY (`id_interes`) REFERENCES `intereses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 4.- Estructura de la tabla `matchs`

CREATE TABLE `matchs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario_1` int(11) NOT NULL,
  `id_usuario_2` int(11) NOT NULL,
  `estado` enum('pendiente','aceptado','rechazado') NOT NULL DEFAULT 'pendiente',
  PRIMARY KEY (`id`),
  KEY `id_usuario_1` (`id_usuario_1`),
  KEY `id_usuario_2` (`id_usuario_2`),
  CONSTRAINT `matchs_ibfk_1` FOREIGN KEY (`id_usuario_1`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matchs_ibfk_2` FOREIGN KEY (`id_usuario_2`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 5.- Estructura de la tabla `reportes`

CREATE TABLE `reportes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario_reportado` int(11) NOT NULL,
  `id_usuario_reporta` int(11) NOT NULL,
  `razon` varchar(255) NOT NULL,
  `fecha_reporte` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario_reportado` (`id_usuario_reportado`),
  KEY `id_usuario_reporta` (`id_usuario_reporta`),
  CONSTRAINT `reportes_ibfk_1` FOREIGN KEY (`id_usuario_reportado`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reportes_ibfk_2` FOREIGN KEY (`id_usuario_reporta`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 6.- Estructura de la tabla `configuraciones`

CREATE TABLE `configuraciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `mostrar_edad` tinyint(1) NOT NULL DEFAULT '1',
  `mostrar_ubicacion` tinyint(1) NOT NULL DEFAULT '1',
  `notificaciones_push` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `configuraciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 7.- Estructura de la tabla `comentarios`

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario_envia` int(11) NOT NULL,
  `id_usuario_recibe` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `fecha_envio` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario_envia` (`id_usuario_envia`),
  KEY `id_usuario_recibe` (`id_usuario_recibe`),
  CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_usuario_envia`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_usuario_recibe`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 8.- Estructura de la tabla `suscripciones`

CREATE TABLE `suscripciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `tipo_suscripcion` enum('gratis','basica','premium') NOT NULL DEFAULT 'gratis',
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `estado` enum('activa','inactiva','cancelada') NOT NULL DEFAULT 'activa',
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `suscripciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 9.- Estructura de la tabla `historial_de_pagos`

CREATE TABLE `historial_de_pagos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_suscripcion` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_pago` datetime NOT NULL,
  `estado` enum('exitoso','fallido','reembolsado') NOT NULL DEFAULT 'exitoso',
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_suscripcion` (`id_suscripcion`),
  CONSTRAINT `historial_de_pagos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historial_de_pagos_ibfk_2` FOREIGN KEY (`id_suscripcion`) REFERENCES `suscripciones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 10.- Estructura de la tabla `fotos`

CREATE TABLE `fotos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `foto` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_subida` datetime NOT NULL,
  `privacidad` enum('publica','privada','solo_matchs') NOT NULL DEFAULT 'publica',
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `fotos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 11.- Estructura de la tabla `tags`

CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 12.- Estructura de la tabla `eventos_en_vivo`

CREATE TABLE `eventos_en_vivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `duracion` time NOT NULL,
  `link` varchar(255) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `privacidad` enum('publico','privado','solo_matchs') NOT NULL DEFAULT 'publico',
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `eventos_en_vivo_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 13.- Estructura de la tabla `soporte`

CREATE TABLE `soporte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `asunto` varchar(100) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` datetime NOT NULL,
  `estado` enum('abierto','cerrado','en_progreso') NOT NULL DEFAULT 'abierto',
  `respuesta` text NOT NULL,
  `fecha_respuesta` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `soporte_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 14.- Estructura de la tabla `preguntas_de_verificación`

CREATE TABLE `preguntas_de_verificación` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(255) NOT NULL,
  `respuesta_correcta` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 15.- Estructura de la tabla `denuncias`

CREATE TABLE `denuncias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario_denunciado` int(11) NOT NULL,
  `id_usuario_denunciante` int(11) NOT NULL,
  `motivo` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_denuncia` datetime NOT NULL,
  `estado` enum('pendiente','investigando','resuelta','cerrada') NOT NULL DEFAULT 'pendiente',
  `resultado` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario_denunciado` (`id_usuario_denunciado`),
  KEY `id_usuario_denunciante` (`id_usuario_denunciante`),
  CONSTRAINT `denuncias_ibfk_1` FOREIGN KEY (`id_usuario_denunciado`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `denuncias_ibfk_2` FOREIGN KEY (`id_usuario_denunciante`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 16.- Estructura de la tabla `contenido_multimedia`

CREATE TABLE `contenido_multimedia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `tipo` enum('foto','video') NOT NULL,
  `archivo` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_subida` datetime NOT NULL,
  `estado` enum('publico','privado') NOT NULL DEFAULT 'publico',
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `contenido_multimedia_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 17.- Estructura de la tabla `filtros_de_búsqueda`

CREATE TABLE `filtros_de_búsqueda` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `edad_minima` int(11) NOT NULL,
  `edad_maxima` int(11) NOT NULL,
  `genero` enum('hombre','mujer','otro') NOT NULL,
  `preferencia_genero` enum('hombre','mujer','otro') NOT NULL,
  `distancia_maxima` int(11) NOT NULL,
  `intereses` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `filtros_de_búsqueda_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 18.- Estructura de la tabla `mensajes`

CREATE TABLE `mensajes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario_1` int(11) NOT NULL,
  `id_usuario_2` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` datetime NOT NULL,
  `leido` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_usuario_1` (`id_usuario_1`),
  KEY `id_usuario_2` (`id_usuario_2`),
  CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`id_usuario_1`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mensajes_ibfk_2` FOREIGN KEY (`id_usuario_2`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 19.- Estructura de la tabla `bloqueos`

CREATE TABLE `bloqueos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_usuario_bloqueado` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_usuario_bloqueado` (`id_usuario_bloqueado`),
  CONSTRAINT `bloqueos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bloqueos_ibfk_2` FOREIGN KEY (`id_usuario_bloqueado`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 20.- Estructura de la tabla `notificaciones_push`

CREATE TABLE `notificaciones_push` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `mensaje` text NOT NULL,
  `tipo` enum('match','mensaje','evento_en_vivo','otro') NOT NULL,
  `fecha_envio` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `notificaciones_push_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 21.- Estructura de la tabla `conversaciones`

CREATE TABLE `conversaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario_1` int(11) NOT NULL,
  `id_usuario_2` int(11) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario_1` (`id_usuario_1`),
  KEY `id_usuario_2` (`id_usuario_2`),
  CONSTRAINT `conversaciones_ibfk_1` FOREIGN KEY (`id_usuario_1`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conversaciones_ibfk_2` FOREIGN KEY (`id_usuario_2`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 22.- Estructura de la tabla `favoritos`

CREATE TABLE `favoritos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_usuario_favorito` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_usuario_favorito` (`id_usuario_favorito`),
  CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_usuario_favorito`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 23.- Estructura de la tabla `usuarios_preguntas_de_verificación`

CREATE TABLE `usuarios_preguntas_de_verificación` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_pregunta` int(11) NOT NULL,
  `respuesta` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_pregunta` (`id_pregunta`),
  CONSTRAINT `usuarios_preguntas_de_verificación_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usuarios_preguntas_de_verificación_ibfk_2` FOREIGN KEY (`id_pregunta`) REFERENCES `preguntas_de_verificación` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 24.- Estructura de la tabla `usuarios_tags`

CREATE TABLE `usuarios_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_tag` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_tag` (`id_tag`),
  CONSTRAINT `usuarios_tags_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usuarios_tags_ibfk_2` FOREIGN KEY (`id_tag`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;