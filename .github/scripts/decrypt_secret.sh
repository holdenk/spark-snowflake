#!/bin/sh

# Below is encrypt command. It needs to input passphrase in promot.
# gpg --symmetric --cipher-algo AES256 snowflake.travis.json

# Decrypt the file
echo "Usage: decrypt_secret.sh output_file_name decrypted_file_name"
echo "       Note: environment variable SNOWFLAKE_TEST_CONFIG_SECRET should be set for descryption."

if [ -z "$SNOWFLAKE_TEST_CONFIG_SECRET" ]; then
  echo "WARNING: SNOWFLAKE_TEST_CONFIG_SECRET is not set or empty. Skipping decryption."
  echo "         Integration tests will be skipped. Unit tests will still run."
  exit 0
fi

# --batch to prevent interactive command --yes to assume "yes" for questions
if ! gpg --quiet --batch --yes --decrypt --passphrase="$SNOWFLAKE_TEST_CONFIG_SECRET" --output $1 $2; then
  echo "WARNING: Failed to decrypt Snowflake test config. Skipping decryption."
  echo "         Integration tests will be skipped. Unit tests will still run."
  exit 0
fi
