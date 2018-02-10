.. -*- coding: utf-8 -*-

===============
Portal del UPTM
===============

:Framework: `Plone 4.3.4 <http://plone.org>`_
:Bug tracker: https://github.com/uptm/uptm.website/issues
:Source: https://github.com/uptm/uptm.website
:Documentation: https://github.com/uptm/uptm.website/wiki/Home

Este paquete instala una instancia de Plone con todos los componentes
necesarios para construir el sitio web del UPTM

Se proporcionan configuraciones para los siguientes entornos:

 - Desarrollo
 - Pruebas
 - Producción

Instalación
===========

Entorno de desarrollo
=====================

Requisitos previos
------------------

 - Python 2.7 y bibliotecas de desarrollo

Crear un archivo ~/.buildout/default.cfg con lo siguiente:

.. code-block:: console

  [buildout]
  download-cache = ~/.buildout/downloads
  eggs-directory = ~/.buildout/eggs
  extends-cache = ~/.buildout/extends

- ``download-cache``: Directorio donde se almacenan los sources de los paquetes
  descargados con los que se construyen los paquetes python (eggs).

- ``eggs-directory``: Directorio donde se almacenan los paquetes python generados.

- ``extends-cache``: Directorio donde se almacenan archivos de configuración (.cfg)
  que son descargados desde la red, generalmente por una clausula ``extends`` y que
  son utilizados cuando el buildout se ejecuta sin conexión (offline mode)


Descargar el buildout
---------------------

Para obtener una copia de este proyecto ejecute las siguientes instrucciones en
lineas de comando:

.. code-block:: console

  $ cd ~
  $ git clone https://github.com/uptm/uptm.website.git


Puede utilizar un nombre de carpeta diferente si así lo desea.

Generar el buildout
-------------------

Para inicializar y construir una copia de este proyecto en entornos de
desarrollo, ejecute las siguientes instrucciones en lineas de comando:

.. code-block:: console

  $ cd ~/uptm.website
  $ python bootstrap.py
  $ ./bin/buildout

Para iniciar la instancia del sitio Plone, ejecute el siguiente comando:

.. code-block:: console

  $ ./bin/instance fg

Puede acceder al sitio a través de la dirección http://localhost:8080/


Entorno de pruebas (staging)
============================

Ingresar al directorio donde se obtuvo la copia del buildout:

.. code-block:: console

  $ cd ~/uptm.website

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

Para iniciar la instancia del sitio Plone, ejecute el siguiente comando:

.. code-block:: console

  $ ./bin/instance fg

Puede acceder al sitio a través de la dirección http://localhost:8080/

En caso de encontrar errores del tipo **"Can't update package 'xxx.yyy' because
its URL doesn't match."** utilice el siguiente comando y ejecute nuevamente el
buildout:

.. code-block:: console

  $ rm -rf ~/uptm/src/xxx.yyy

Reemplace "xxx.yyy" por el nombre del paquete que se muestra en el mensaje de
error.

Pasos comunes para el entorno de producción y pruebas
=====================================================

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

    $ git clone git@github.com/uptm/uptm.website.git
    Initialized empty Git repository in /srv/plone/uptm.website/.git/
    Password:

    $ cd uptm.website

Generar el buildout y lo ejecutarlo con el perfil de producción según sea
una instancia.

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

Descargas
=========

Usted puede encontrar la versión de desarrollo del paquete ``uptm.website``
en el `repositorio UPTM`_ en Github.com.

Sobre la calidad
================

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