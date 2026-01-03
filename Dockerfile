FROM postgres:17

# Install build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    postgresql-server-dev-17 \
    && rm -rf /var/lib/apt/lists/*

# Install pgvector
RUN cd /tmp && \
    git clone --branch v0.7.0 https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make && make install && \
    rm -rf /tmp/pgvector

# Clean up build tools
RUN apt-get purge -y --auto-remove build-essential git

# Copy init scripts
COPY init-databases.sql /docker-entrypoint-initdb.d/
