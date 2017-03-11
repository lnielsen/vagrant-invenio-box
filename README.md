# Vagrant boxes for Invenio

All boxes are based on Ubuntu 16.04 LTS.

If a service requires username and password then these are set to:

- User: ``invenio``
- Password: ``invenio``

The IP address is usually set to ``192.168.33.3``.

### Base

The Invenio Base box includes the following pre-installed and configured
services:

- SSH (port 22)
- PostgreSQL (port 5432)
- Redis (port 6379)
- RabbitMQ (port 5672)
  - with management interface (port 15672)
  - with vhost ``invenio``
- Elasticsearch 2.x (port 9200)
  - with analysis-icu and mapper-attachments plugins
