README - Trabajo Práctico: Gestión de Carpetas

Comandos utilizados y su propósito:

1. mkdir -p: Crear el workspace de forma recursiva si no existe
2. cd: Cambiar al directorio workspace para todas las operaciones
3. ls -1d */: Listar solo directorios, uno por línea
4. mv: Renombrar/mover carpetas de forma segura
5. rmdir: Eliminar carpetas solo si están vacías (comportamiento seguro)
6. rm -rf: Eliminar recursivamente y forzadamente cuando el usuario confirma
7. test -d: Validar existencia de directorios antes de operar
8. case/read: Implementar menú interactivo con validación de opciones

Validaciones implementadas:
- Espacios al inicio/fin en nombres
- Caracteres prohibidos (/ y ..)
- Rutas absolutas
- Existencia de carpetas antes de operar
- Confirmación para eliminación forzada

El script opera exclusivamente en /tmp/tp_carpetas_$USER para garantizar aislamiento y seguridad.
