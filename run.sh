#!/usr/bin/env bash

PROJECT_PATH=$HOME
LOG_PATH=/tmp

install_dependencies() {
  apt install git just
  git clone git@github.com:vncsmyrnk/meilisearch.git $PROJECT_PATH
}

build_nix() {
  cd $PROJECT_PATH/meilisearch
  start=$(date +%s)
  just nix-docker-build
  end=$(date +%s)
  runtime=$((end - start))

  NIX_LOG_PATH=$LOG_PATH/meilisearch/nix-build
  mkdir -p $NIX_LOG_PATH
  cat <<- EOF > $NIX_LOG_PATH/summary.txt
  Total time: $runtime
  EOF

  docker save meilisearch-local-nix:1.21.0 | gzip > $NIX_LOG_PATH/image.tar.gz
}

build_traditional() {
  cd $PROJECT_PATH/meilisearch
  start=$(date +%s)
  just run-conventional-docker-build
  end=$(date +%s)
  runtime=$((end - start))

  TRADITIONAL_LOG_PATH=$LOG_PATH/meilisearch/traditional-build
  mkdir -p $TRADITIONAL_LOG_PATH
  cat <<- EOF > $TRADITIONAL_LOG_PATH/summary.txt
  Total time: $runtime
  EOF

  docker save meilisearch-local-buildx:latest | gzip > $TRADITIONAL_LOG_PATH/image.tar.gz
}

main() {

}
