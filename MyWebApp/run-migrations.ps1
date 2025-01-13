dotnet ef migrations script | Add-Content -Path "migrations.sql"



# Skapa eller skriv över migrations.sql med databaskommandot
# Lägg till \c product_database som första rad
Set-Content -Path "migrations.sql" -Value "\c product_database"

# Lägg till migrationsscriptet
dotnet ef migrations script | Add-Content -Path "migrations.sql"


