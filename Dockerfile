FROM postgres:17-alpine

# Install build tools (including clang/llvm required for pgvector)
RUN apk add --no-cache \
    build-base \
    git \
    clang15 \
    llvm15-dev \
    postgresql-dev

# Install pgvector
RUN cd /tmp && \
    git clone --branch v0.7.0 https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make OPTFLAGS="" && make install && \
    rm -rf /tmp/pgvector

# Clean up build tools to reduce image size
RUN apk del build-base git clang15 llvm15-dev

# Copy init scripts
COPY init-databases.sql /docker-entrypoint-initdb.d/
