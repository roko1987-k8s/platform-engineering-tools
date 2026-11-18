# platform-engineering-tools

Catálogo central de las **tools de plataforma** que el Tools Agent instala con Helm en los clústeres de los equipos
(EKS y AKS). Solo herramientas open source; mismos charts, repositorios y versiones en todas las nubes.

| Ruta | Contenido |
|---|---|
| `catalog/tools.yaml` | Esquema `adp-tools-catalog-v1`: herramientas, obligatoria u opcional, orden, dependencias, releases (chart, repositorio permitido, versión exacta, namespace) y cómo se detectan en el clúster |
| `values/base/<values>.yaml` | Values comunes de cada release |
| `values/aws/`, `values/azure/` | Solo lo que cambia por nube (p. ej. `storageClass`) |

## Reglas

- Versiones exactas, nunca rangos. Cambiar una versión = PR revisado + tag nuevo `tools-vX.Y.Z`.
- Solo repositorios Helm de la lista `repositories`.
- `required: true` = obligatoria en GP04 (el equipo no puede quitarla); `false` = opcional.
- `workloads` y `version_from` deben coincidir con lo que el chart crea (se comprueba con `helm template`): la
  detección del Tools Agent lee esos recursos con un rol de solo lectura (no lee los Secrets de Helm).
- Sin secretos, rutas locales ni datos de equipos. La configuración de cada clúster vive en el repo gitops.

## Añadir una herramienta

1. Añadir el repositorio (si es nuevo) y la entrada en `tools` con su versión exacta.
2. Crear `values/base/<values>.yaml` (y por nube si hace falta).
3. `helm template` del chart con esos values para comprobar `workloads` y `version_from`.
4. PR, revisión y tag `tools-vX.Y.Z`.
