# platform-engineering-tools

Catálogo central de las **tools de plataforma** de los clústeres de los equipos (EKS y AKS). El Tools Agent instala
Argo CD con Helm y abre un PR al repo gitops con la carpeta del clúster; Argo CD instala el resto desde esa carpeta.
Solo herramientas open source; mismos charts, repositorios y versiones en todas las nubes.

| Ruta | Contenido |
|---|---|
| `versions/main.tf` | **Único sitio con versiones** y con obligatoria (`required = true`, se instala siempre) u opcional (`false`, solo si el equipo la marca). Solo datos: nadie ejecuta Terraform sobre él |
| `catalog/tools.yaml` | Esquema `adp-tools-catalog-v2`: estructura técnica de cada herramienta (repositorio permitido, chart, release, namespace, orden, dependencias) y cómo se detecta en el clúster; sin versiones |
| `values/base/<values>.yaml` | Values comunes de cada release |
| `values/aws/`, `values/azure/` | Solo lo que cambia por nube (p. ej. `storageClass`) |

## Reglas

- Versiones exactas, nunca rangos, solo en `versions/main.tf`. Cambiar una versión = PR revisado + tag nuevo
  `tools-vX.Y.Z`; el Tools Agent lleva la versión a la carpeta de cada clúster del repo gitops mediante PR.
- Lo que elige cada equipo (opcionales marcadas) no se guarda aquí: queda en la carpeta de su clúster en gitops.
- Solo repositorios Helm de la lista `repositories`.
- `workloads` y `version_from` deben coincidir con lo que el chart crea (se comprueba con `helm template`): la
  detección del Tools Agent lee esos recursos con un rol de solo lectura (no lee los Secrets de Helm).
- Sin secretos, rutas locales ni datos de equipos. La configuración de cada clúster vive en el repo gitops.

## Añadir una herramienta

1. Añadir el repositorio (si es nuevo) y la entrada en `tools` de `catalog/tools.yaml`; su versión exacta y
   `required` en `versions/main.tf`.
2. Crear `values/base/<values>.yaml` (y por nube si hace falta).
3. `helm template` del chart con esos values para comprobar `workloads` y `version_from`.
4. PR, revisión y tag `tools-vX.Y.Z`.
