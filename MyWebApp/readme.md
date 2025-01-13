
# Köra appen

För att köra appen behöver du ha Docker installerat.

Sedan är det bara att skriva

    docker compose up

Vilket kommer dra igång en webbapp och en postgres-databas i var sin container.

Du når sidan på http://localhost:1234

# Skapa migrationsscript 

Om databasscripten inte är i synk så uppdatera dem genom att köra

    dotnet ef migrations script -o migrations.sql

