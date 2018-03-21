.. -*- coding: utf-8 -*-

.. highlight:: rest

.. _que_es_buildout:

Buildout
========

`Buildout`_ es una herramienta que permite descargar, de manera automatizada, 
todo el software necesario para construir y ensamblar una copia de Plone 4.3.x.

Los desarrolladores de Plone usan ``buildout`` por que facilita el control de 
versiones de paquetes individuales y el desarrollo de paquetes nuevos.

Los administradores e integradores de Plone usan ``buildout`` por que facilita 
la construcción de todas las piezas de software necesarias para el despliegue 
de sus proyecto, compilando y instalando, tanto servicios como sus configuraciones.

Buildout se definen mediante los archivos de configuración. Estos están en el 
formato definido por el módulo `ConfigParser`_ Python, con extensiones Que vamos 
a describir más adelante. De forma predeterminada, cuando se ejecuta el buildout, 
busca el archivo ``buildout.cfg`` en el directorio donde se ejecuta el buildout.

.. _por_que_buildout:

¿Por que usar buildout con Plone?
----------------------------------

Es el mecanismo por defecto para construir Plone, ademas gracias a las :ref:`configuraciones <configuraciones_buildout>`, orquesta todos los servicios de :ref:`Alta disponibilidad para Plone <requerimientos>`.

..
	Instalando zc.buildout
	----------------------
	Para instalar ``buildout`` dentro de un entorno virtual activo, ejecute el siguiente comando:

	.. code-block:: console

	    (python2.7)$ pip2.7 install "zc.buildout==1.7.1"

Configurando zc.buildout
-------------------------

Es ideal aplicar estas configuraciones Buildout en usuario local para compartir localmente 
los paquetes descargados con otros proyectos Buildout, ejecutando el siguiente comando:

.. code-block:: sh

  $ mkdir -p $HOME/.buildout/{downloads,eggs,extends,zope} && echo $HOME $HOME $HOME $HOME | awk '{ printf( "[buildout]\neggs-directory = %s/.buildout/eggs\ndownload-cache = %s/.buildout/downloads\nextends-cache = %s/.buildout/extends\nzope-directory = %s/.buildout/zope\nabi-tag-eggs = true\n", $1, $2, $3, $4 ) }' >> ~/.buildout/default.cfg

Este comando genera el archivo ~/.buildout/default.cfg con la siguientes configuraciones que se describen a continuación:

- ``download-cache``: Directorio donde se almacenan los sources de los paquetes
  descargados con los que se construyen los paquetes python (eggs).

- ``eggs-directory``: Directorio donde se almacenan los paquetes python generados.

- ``extends-cache``: Directorio donde se almacenan archivos de configuración (.cfg)
  que son descargados desde la red, generalmente por una clausula ``extends`` y que
  son utilizados cuando el buildout se ejecuta sin conexión (offline mode)


.. _Buildout: https://pypi.python.org/pypi/zc.buildout/
.. _ConfigParser: https://docs.python.org/2/library/configparser.html
