# Basbild
FROM postgres:latest

# Sätt miljövariabler
ENV POSTGRES_USER=username
ENV POSTGRES_PASSWORD=strong_password
ENV POSTGRES_DB=product_database

# Specifiera arbetskatalogen (valfritt)
WORKDIR /var/lib/postgresql/data

# Exponera standard PostgreSQL-port
EXPOSE 5432

# Volym för att behålla data
VOLUME /var/lib/postgresql/data
