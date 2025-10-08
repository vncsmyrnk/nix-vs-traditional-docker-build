default:
  just --list

# Spins up an SFTP server for artifact collecting
run-sftp-server:
  docker run --rm -it  \
    -v /tmp/sftp:/home/sftpuser \
    -p 2222:22 atmoz/sftp \
    sftpuser:aPassword:1000
