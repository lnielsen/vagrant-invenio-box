# Activate virutal environment
source /opt/invenio/bin/activate

# Install assets
invenio npm
cd /opt/invenio/var/instance/static
npm install

# Build assets
invenio collect -v
invenio assets build

# Create database tables
invenio db create

# Create indexes
invenio index init
invenio index queue init

# Load demo data
invenio demo init
