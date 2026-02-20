#!/bin/bash
# Database Restore Script

set -e

# Configuration
DATABASE_ID="${DATABASE_ID:-}"
BACKUP_ID="${BACKUP_ID:-}"

if [ -z "$DATABASE_ID" ] || [ -z "$BACKUP_ID" ]; then
  echo "Usage: $0"
  echo "Environment variables:"
  echo "  DATABASE_ID - DigitalOcean database ID"
  echo "  BACKUP_ID - Backup ID to restore from"
  echo ""
  echo "Example:"
  echo "  DATABASE_ID=abc123 BACKUP_ID=xyz789 $0"
  exit 1
fi

echo "WARNING: This will restore database $DATABASE_ID from backup $BACKUP_ID"
echo "This operation may cause data loss!"
read -p "Are you sure you want to continue? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo "Restore cancelled"
  exit 0
fi

echo "Restoring database $DATABASE_ID from backup $BACKUP_ID..."

# Restore from backup
doctl databases restore "$DATABASE_ID" --backup-id "$BACKUP_ID"

echo "Restore initiated successfully!"
echo "Monitor the restore progress in the DigitalOcean console."
echo ""
echo "To check restore status:"
echo "  doctl databases backup list $DATABASE_ID"
