# Activar auditoría de gestión de cuentas
Write-Host "Activando auditoría..." -ForegroundColor Cyan
auditpol /set /subcategory:"User Account Management" /success:enable /failure:enable

Start-Sleep -Seconds 2

# Crear nuevo usuario de prueba
Write-Host "Creando usuario testuser1..." -ForegroundColor Cyan
$password = ConvertTo-SecureString "Test1234!" -AsPlainText -Force
New-LocalUser -Name "testuser1" -Password $password -FullName "Usuario de prueba" -Description "Cuenta temporal de prueba"

Start-Sleep -Seconds 2

# Agregar al grupo de administradores
Write-Host "Agregando testuser1 al grupo Administrators..." -ForegroundColor Cyan
Add-LocalGroupMember -Group "Administrators" -Member "testuser1"

Start-Sleep -Seconds 2

# Cambiar nombre de cuenta
Write-Host "Renombrando testuser1 a testuser_renamed..." -ForegroundColor Cyan
Rename-LocalUser -Name "testuser1" -NewName "testuser_renamed"

Start-Sleep -Seconds 2

# Eliminar el usuario
Write-Host "Eliminando usuario testuser_renamed..." -ForegroundColor Cyan
Remove-LocalUser -Name "testuser_renamed"

Start-Sleep -Seconds 3

# Consultar eventos relevantes
Write-Host "Extrayendo eventos del log de seguridad..." -ForegroundColor Green
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4720,4726,4732,4733,1102,4781} |
    Format-Table TimeCreated, Id, Message -AutoSize


    