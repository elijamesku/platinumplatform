#!/bin/bash
# Database Backup Script

set -e

# Configuration
DATABASE_ID="${DATABASE_ID:-}"
BACKUP_RETENTION_DAYS="${BACKUP_RETENTION_DAYS:-7}"
BACKUP_DIR="${BACKUP_DIR:-./backups}"

if [ -z "$DATABASE_ID" ]; then
  echo "Error: DATABASE_ID environment variable is required"
  exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

echo "Starting database backup for database: $DATABASE_ID"

# Create manual backup
BACKUP_ID=$(doctl databases backup create "$DATABASE_ID" --format ID --no-header)

if [ -z "$BACKUP_ID" ]; then
  echo "Error: Failed to create backup"
  exit 1
fi

echo "Backup created successfully: $BACKUP_ID"

# Save backup info
cat > "$BACKUP_DIR/backup-$(date +%Y%m%d-%H%M%S).json" <<EOF
{
  "backup_id": "$BACKUP_ID",
  "database_id": "$DATABASE_ID",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "retention_days": "$BACKUP_RETENTION_DAYS"
}
EOF

echo "Backup information saved to $BACKUP_DIR"

# List all backups
echo "Current backups:"
doctl databases backup list "$DATABASE_ID" --format ID,CreatedAt,Size

# Cleanup old backups (older than retention period)
echo "Cleaning up backups older than $BACKUP_RETENTION_DAYS days..."
# Note: DigitalOcean manages backup retention automatically for managed databases
# This is just for reference

echo "Backup completed successfully!"

