# ---------------------------------------------------------
# PASO 0: VERIFICAR TOKEN (SEGURIDAD)
# ---------------------------------------------------------
if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ ERROR: La variable GITHUB_TOKEN está vacía."
    echo "   1. Genera un token NUEVO en: https://github.com/settings/tokens "
    echo "   2. Ejecuta: export GITHUB_TOKEN='ghp_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'"
    echo "   3. Vuelve a ejecutar este script."
    exit 1
fi

echo "✅ Token detectado. Procediendo..."

# ---------------------------------------------------------
# PASO 1: CONFIGURAR IDENTIDAD
# ---------------------------------------------------------
echo "🔧 Configurando identidad..."
git config --global user.name "Yoany Fuentes Ruiz"
git config --global user.email "yfuentes9002@gmail.com"

# ---------------------------------------------------------
# PASO 2: CONFIGURAR CREDENCIALES
# ---------------------------------------------------------
echo "🔒 Configurando credenciales..."
git config --global credential.helper store
echo "https://x-access-token:${GITHUB_TOKEN}@github.com" > ~/.git-credentials
chmod 600 ~/.git-credentials

# ---------------------------------------------------------
# PASO 3: PROBAR CONEXIÓN (CORREGIDO)
# ---------------------------------------------------------
echo "🚀 Probando conexión con GitHub..."

REPO_URL="https://github.com/YoanyFR9002/YoanyFR9002.git"
TEMP_DIR="test-clone-temp"

rm -rf "$TEMP_DIR"

if git clone "$REPO_URL" "$TEMP_DIR"; then
    echo "✅ Clonación exitosa."
    if [ -d "$TEMP_DIR" ]; then
        cd "$TEMP_DIR" && echo "✅ Conexión GitHub OK (Repo accesible)" && cd ..
        rm -rf "$TEMP_DIR"
        echo "✅ Prueba completada y carpeta temporal eliminada."
    fi
else
    echo "❌ Error al clonar."
    echo "   Posibles causas:"
    echo "   1. El token es inválido, expiró o fue revocado."
    echo "   2. El repositorio no existe o es privado sin acceso."
    echo "   3. Problemas de red."
    exit 1
fi
EOF