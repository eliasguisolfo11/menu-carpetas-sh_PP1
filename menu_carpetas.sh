#!/bin/bash

# Configuración inicial
WORKSPACE="/tmp/tp_carpetas_$USER"

# Función para inicializar el workspace
inicializar_workspace() {
    if [ ! -d "$WORKSPACE" ]; then
        echo "Creando workspace en: $WORKSPACE"
        mkdir -p "$WORKSPACE"
    fi
    cd "$WORKSPACE" || exit 1
    echo "Workspace activo: $(pwd)"
}

# Función para validar nombre
validar_nombre() {
    local nombre="$1"
    
    # Validar vacío
    if [ -z "$nombre" ]; then
        echo "Error: El nombre no puede estar vacío."
        return 1
    fi
    
    # Validar espacios extremos
    if [[ "$nombre" != "${nombre## }" || "$nombre" != "${nombre%% }" ]]; then
        echo "Error: El nombre no puede tener espacios al inicio o final."
        return 1
    fi
    
    # Validar caracteres prohibidos
    if [[ "$nombre" == *"/"* || "$nombre" == *".."* ]]; then
        echo "Error: El nombre no puede contener '/' o '..'"
        return 1
    fi
    
    # Validar ruta absoluta
    if [[ "$nombre" == /* ]]; then
        echo "Error: No se permiten rutas absolutas."
        return 1
    fi
    
    return 0
}

# Función para crear carpeta
crear_carpeta() {
    echo -n "Ingrese el nombre de la carpeta: "
    read nombre
    
    if validar_nombre "$nombre"; then
        if [ -d "$nombre" ]; then
            echo "Error: La carpeta '$nombre' ya existe."
        else
            mkdir "$nombre"
            echo "Carpeta '$nombre' creada exitosamente."
        fi
    fi
}

# Función para listar carpetas
listar_carpetas() {
    echo "Carpetas en el workspace:"
    if [ -z "$(ls -d */ 2>/dev/null)" ]; then
        echo "No hay carpetas en el workspace."
    else
        ls -1d */
    fi
}

# Función para renombrar carpeta
renombrar_carpeta() {
    echo -n "Ingrese el nombre de la carpeta a renombrar: "
    read origen
    
    if [ ! -d "$origen" ]; then
        echo "Error: La carpeta '$origen' no existe."
        return
    fi
    
    echo -n "Ingrese el nuevo nombre: "
    read destino
    
    if validar_nombre "$destino"; then
        if [ -d "$destino" ]; then
            echo "Error: Ya existe una carpeta con el nombre '$destino'."
        else
            mv "$origen" "$destino"
            echo "Carpeta '$origen' renombrada a '$destino'."
        fi
    fi
}

# Función para eliminar carpeta
eliminar_carpeta() {
    echo -n "Ingrese el nombre de la carpeta a eliminar: "
    read nombre
    
    if [ ! -d "$nombre" ]; then
        echo "Error: La carpeta '$nombre' no existe."
        return
    fi
    
    # Intentar eliminar con rmdir (solo si está vacía)
    if rmdir "$nombre" 2>/dev/null; then
        echo "Carpeta '$nombre' eliminada (estaba vacía)."
    else
        echo "La carpeta '$nombre' no está vacía."
        echo -n "¿Desea forzar la eliminación? (S/N): "
        read respuesta
        
        case $respuesta in
            [Ss]*)
                rm -rf "$nombre"
                echo "Carpeta '$nombre' eliminada forzosamente."
                ;;
            *)
                echo "Eliminación cancelada."
                ;;
        esac
    fi
}

# Función principal del menú
mostrar_menu() {
    echo ""
    echo "=== MENÚ DE GESTIÓN DE CARPETAS ==="
    echo "1) Crear carpeta"
    echo "2) Listar carpetas"
    echo "3) Renombrar carpeta"
    echo "4) Eliminar carpeta"
    echo "5) SALIR"
    echo -n "Seleccione una opción [1-5]: "
}

# Programa principal
main() {
    echo "Iniciando script de gestión de carpetas..."
    inicializar_workspace
    
    while true; do
        mostrar_menu
        read opcion
        
        case $opcion in
            1) crear_carpeta ;;
            2) listar_carpetas ;;
            3) renombrar_carpeta ;;
            4) eliminar_carpeta ;;
            5) 
                echo "Saliendo del programa. ¡Hasta luego!"
                break
                ;;
            *)
                echo "Opción inválida. Por favor, seleccione 1-5."
                ;;
        esac
    done
}

# Ejecutar programa principal
main
