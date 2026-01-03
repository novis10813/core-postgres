FROM postgres:17-alpine

# Install build tools
RUN apk add --no-cache \
    build-base \
    git \
    postgresql-dev

# Install pgvector
RUN cd /tmp && \
    git clone --branch v0.7.0 https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make && make install && \
    rm -rf /tmp/pgvector

# Clean up build tools
RUN apk del build-base git

# Copy init scripts
COPY init-databases.sql /docker-entrypoint-initdb.d/
