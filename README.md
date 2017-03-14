# Vagrant boxes for Invenio

All boxes are based on Ubuntu 16.04 LTS.

If a service requires username and password then these are set to:

- User: ``invenio``
- Password: ``invenio``

The IP address is usually set to ``192.168.33.3``.

All boxes come with a local user (``invenio``/``invenio``) that you can login
with.

### Base

The Invenio Base box includes the following pre-installed and configured
services:

- SSH (port 22)
- PostgreSQL (port 5432)
  - with database ``invenio``.
- Redis (port 6379)
- RabbitMQ (port 5672)
  - with management interface (port 15672)
  - with vhost ``invenio``
- Elasticsearch 2.x (port 9200)
  - with analysis-icu and mapper-attachments plugins

The base box has the following packages installed:

- ``libcairo2-dev``
- ``fonts-dejavu``
- ``libfreetype6-dev``

The following node packages are installed globally:

- ``clean-css``
- ``uglifyjs``
- ``requirejs``
- ``node-sass``

Last, the base box have a Python virtual environment owned by ``invenio`` user
located in ``/opt/invenio``. You can activate the virtualenv with:

```console
$ source /opt/invenio/bin/activate
```

### ILS

The Invenio ILS box comes with all of base plus Invenio ILS installed + demo
data. To start Invenio, log into the box and start a development server like
this:

```console
$ ssh invenio@192.168.33.3
$ source /opt/invenio/bin/activate
(ils)$ invenio run -h 0.0.0.0
```

You can now browse Invenio ILS on:

- [http://192.168.33.3:5000](http://192.168.33.3:5000)

## Export as VirtualBox VM

1.  Open VirtualBox GUI and locate the VM.
1.  Right click on the VM and select "Settings".
1.  Go to the Shared Folder tab and remove any shared folder.
1.  Go to the menu point File > Export Appliance and use the defaults to export
    the VM in OVA format.
