# Ruta de salida
$destino = "C:\Forensics\Historial"
if (!(Test-Path $destino)) {
    New-Item -Path $destino -ItemType Directory
}

# Diccionario de navegadores y rutas
$navegadores = @{
    "Chrome"  = "C:\url\to\chromehistory\History"
    "Edge"    = "C:\url\to\edgehistory\History"
}

# Recorrer y copiar
foreach ($navegador in $navegadores.Keys) {
    $ruta = $navegadores[$navegador]
    if ($ruta -is [array]) {
        foreach ($archivo in $ruta) {
            if (Test-Path $archivo) {
                Copy-Item $archivo -Destination "$destino\$navegador-Historial.sqlite" -Force
                Write-Output "$navegador → Historial encontrado y copiado."
            } else {
                Write-Output "$navegador → Ruta no encontrada: $archivo"
            }
        }
    } else {
        if (Test-Path $ruta) {
            Copy-Item $ruta -Destination "$destino\$navegador-Historial.sqlite" -Force
            Write-Output "$navegador → Historial encontrado y copiado."
        } else {
            Write-Output "$navegador → Ruta no encontrada: $ruta"
        }
    }
}
