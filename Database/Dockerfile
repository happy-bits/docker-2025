# Basbild
FROM postgres:latest

# Sätt miljövariabler
# Skapar en admin med namnet "postgres" och med systemdatabasen "postgres" (detta är default)
# Sätt databasen till "product_database" som default
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=strong_password
ENV POSTGRES_DB=product_database 

# Kopiera SQL-skript till docker-init mappen
COPY reset-database.sql /docker-entrypoint-initdb.d/1-reset-database.sql
COPY migrations.sql /docker-entrypoint-initdb.d/2-migrations.sql


# Specifiera arbetskatalogen (valfritt)
WORKDIR /var/lib/postgresql/data

# Exponera standard PostgreSQL-port
EXPOSE 5432

