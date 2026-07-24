#!/bin/bash
# rename_fotos.sh - Renombra fotos a foto1.jpg, foto2.jpg, ...

# Carpeta donde están las fotos
GALLERY_DIR="/home/kr3s4l4/Github/kr3s4l4.github.io/assets/images/gallery"

cd "$GALLERY_DIR" || exit 1

# Contador
counter=1

# Renombrar todas las imágenes (jpg, jpeg, png, webp)
for file in *.{jpg,jpeg,png,webp,JPG,JPEG,PNG,WEBP}; do
    # Saltar si no hay archivos que coincidan
    [ -f "$file" ] || continue
    
    # Obtener la extensión (en minúsculas para mantenerla)
    ext=$(echo "${file##*.}" | tr '[:upper:]' '[:lower:]')
    
    # Si ya es foto1.jpg, foto2.jpg, etc., saltar (evita duplicados)
    if [[ "$file" =~ ^foto[0-9]+\.[a-zA-Z]+$ ]]; then
        echo "⏭️ Saltando: $file (ya tiene nombre de serie)"
        continue
    fi
    
    new_name="foto$counter.$ext"
    
    # Si el nuevo nombre ya existe, buscar el siguiente disponible
    while [ -f "$new_name" ]; do
        counter=$((counter + 1))
        new_name="foto$counter.$ext"
    done
    
    mv "$file" "$new_name"
    echo "✅ $file → $new_name"
    counter=$((counter + 1))
done

echo "🎯 Total: $((counter - 1)) fotos renombradas"
