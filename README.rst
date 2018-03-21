.. -*- coding: utf-8 -*-

===============
Portal del UPTM
===============

:Framework: `Plone 4.3.15 <http://plone.org>`_
:Bug tracker: https://github.com/uptm/uptm.website/issues
:Source: https://github.com/uptm/uptm.website
:Documentation: https://github.com/uptm/uptm.website/wiki/Home

Este paquete instala una instancia de Plone con todos los componentes
necesarios para construir el sitio web del UPTM


Requisitos previos
==================

 - Python 2.7 y bibliotecas de desarrollo


Descargar código
================

Usted puede encontrar la versión de desarrollo del paquete ``uptm.website``
en el `repositorio UPTM`_ en Github.com.

Para obtener una copia del proyecto en Git, ejecute los siguientes comando:

.. code-block:: console

    $ cd ~
    $ git clone https://github.com/uptm/uptm.website.git


Instalación
===========

Se proporcionan configuraciones para los siguientes entornos:

 - Desarrollo (Development)
 - Pruebas (Staging)
 - Producción (Production)


Entorno de Desarrollo
---------------------

Generar el buildout
++++++++++++++++++++

Para **inicializar** una copia de este proyecto en entornos de desarrollo, 
ejecute las siguientes instrucciones en lineas de comando:

.. code-block:: console

    $ cd ~/uptm.website
    $ make generate-files

..
  .. code-block:: console

    $ cp ./templates/buildout.cfg.ini ./buildout.cfg
    $ cp ./templates/site-settings.cfg.ini ./buildout.d/site-settings.cfg


  Edite el archivo ``./buildout.cfg`` generado y este archivo debería lucir así::

    [buildout]
    extends = buildout.d/development.cfg
    #extends = buildout.d/staging.cfg
    #extends = buildout.d/production.cfg

  **NOTA:** Guarde el cambio realizado, de esta forma, le indica a Buildout 
  que importe las configuraciones del entorno de trabajo de desarrollo 
  "development".


Archivo site-settings.cfg
^^^^^^^^^^^^^^^^^^^^^^^^^^
Este archivo contiene variables globales de configuraciones de su proyecto,
usted **DEBE** actualizar sus valores, para eso edite el archivo 
``./buildout.d/site-settings.cfg`` generado a sus necesidades.

**NOTA:** Guarde el cambio realizado, de esta forma, le indica a Buildout 
que importe las variables de las configuraciones del de los datos propios 
del sitio web.


Construir buildout
+++++++++++++++++++

Para **construir** una copia de este proyecto en entornos de
desarrollo, ejecute las siguientes instrucciones en lineas de comando:

..
  .. code-block:: console

    $ virtualenv .
    $ source ./bin/activate
    $ python bootstrap.py
    $ ./bin/buildout -t 120

.. code-block:: console

  $ make devel

Para iniciar la instancia del sitio Plone, ejecute el siguiente comando:

.. code-block:: console

  $ ./bin/zeoserver fg
  $ ./bin/client1 fg

Puede acceder al sitio a través de la dirección http://localhost:8080/


Entorno de Pruebas
-------------------

Ingresar al directorio donde se obtuvo la copia del buildout:

.. code-block:: console

  $ cd ~/uptm.website

..
  Una vez realizado ese paso, debe modificar el archivo **buildout.cfg**
  con el siguiente comando ::

    $ vim buildout.cfg
    
  Y este archivo debería lucir así::
    
    [buildout]
    #extends = buildout.d/development.cfg
    extends = buildout.d/staging.cfg
    #extends = buildout.d/production.cfg
    
  Luego inicie la construcción con el siguiente comando ::
    
    $ python bootstrap.py
    $ ./bin/buildout -vvvvvvN

Luego inicie la construcción con el siguiente comando :

.. code-block:: console

    $ make buildout-cfg-stag

Para iniciar la instancia del sitio Plone, ejecute el siguiente comando:

.. code-block:: console

  $ ./bin/zeoserver fg
  $ ./bin/client1 fg

Puede acceder al sitio a través de la dirección http://localhost:8080/


Entorno de Producción
----------------------

Pasos comunes para el entorno de producción y pruebas

Ejecución paso a paso:

Instalación de dependencias del sistema operativo:

.. code-block:: console

    $ sudo apt-get install git-core python-dev build-essential libjpeg62-dev \
                   libfreetype6-dev zlib1g-dev libxml2 libxml2-dev libxslt1-dev \
                   libmysqlclient-dev wv poppler-utils lynx munin libwww-perl

Crear el usuario de sistema:

.. code-block:: console

    $ sudo adduser --system --home /srv/plone \
                   --disabled-password --disabled-login plone

Acceder al usuario, clonar el repositorio y correr el bootstrap:

.. code-block:: console

    $ sudo -u plone -s -H
    $ git clone https://github.com/uptm/uptm.website.git
    Initialized empty Git repository in /srv/plone/uptm.website/.git/
    Password:
    $ cd uptm.website

Generar el buildout y lo ejecutarlo con el perfil de producción según sea
una instancia.

.. code-block:: console

    $ make prod

..
  Una vez realizado ese paso, debe modificar el archivo **buildout.cfg**
  con el siguiente comando ::

    $ vim buildout.cfg
    
  Y este archivo debería lucir así::
    
    [buildout]
    #extends = buildout.d/development.cfg
    #extends = buildout.d/staging.cfg
    extends = buildout.d/production.cfg
    
  Luego inicie la construcción con el siguiente comando ::
    
    $ python bootstrap.py
    $ ./bin/buildout -vvvvvvN

Iniciar las instancias manualmente.

.. code-block:: console

    $ bin/supervidord

Actualizar la configuración de las servicios del SO:
 (haproxy, varnish y nginx).

Ejecutar el siguiente comando desde un usuario que tenga los privilegios
necesarios para utilizar sudo.

.. code-block:: console

    $ bin/update-so-config.sh


Errores comunes
===============

**Error:** **"Can't update package 'xxx.yyy' because its URL doesn't match."**

**Solución:** En caso de encontrar errores del tipo **"Can't update package 'xxx.yyy' because
its URL doesn't match."** utilice el siguiente comando y ejecute nuevamente el
buildout:

.. code-block:: console

  $ rm -rf ~/uptm/src/xxx.yyy

Reemplace "xxx.yyy" por el nombre del paquete que se muestra en el mensaje de
error.


Sobre la calidad
================
..
  .. image:: https://d2weczhvl823v0.cloudfront.net/uptm/uptm.website/trend.png
     :alt: Bitdeli badge
     :target: https://bitdeli.com/free

.. image:: https://travis-ci.org/uptm/uptm.website.svg?branch=master
    :alt: Travis-CI badge
    :target: https://travis-ci.org/uptm/uptm.website


¿Tienes una idea?, ¿Encontraste un error? Háganos saber mediante la `apertura de un ticket de soporte`_.

Autor(es) Original(es)
======================

* Leonardo J .Caballero G. aka macagua

Colaboraciones impresionantes
=============================

* Nombre Completo aka apodo


Para una lista actualizada de todo los colaboradores visite:
https://github.com/uptm/uptm.website/contributors

.. _sitio Web de UPTM: http://www.uptm.edu.ve/
.. _repositorio UPTM: https://github.com/uptm/uptm.website
.. _apertura de un ticket de soporte: https://github.com/uptm/uptm.website/issues
