default: help

# Agregar texto de ayuda después de cada target name iniciando con ' \#\# '
help:
	@grep " ## " $(MAKEFILE_LIST) | grep -v MAKEFILE_LIST | sed 's/\([^:]*\).*##/\1\t/'


####################################################################
# Atajos básicos

bin/python2.7: ## 	 Crear virtualenv para Python 2.7
	@virtualenv --clear -p python2.7 .
	@rm -rf local/lib/python2.7/site-packages/easy_install* local/lib/python2.7/site-packages/setuptools* 2>/dev/null || true

generate-files: ## 	 Generar archivos iniciales
	cp templates/buildout.cfg.ini buildout.cfg
	cp templates/site-settings.cfg.ini buildout.d/site-settings.cfg

bin/buildout: bin/python2.7
	@bin/pip install -UIr requirements.txt

####################################################################
# Mantenimiento

all-clean: db-clean clean

db-clean:
	bin/supervisorctl shutdown || true
	@echo "Esto destruira su base de datos locales! Presione Ctrl + C para abortar..."
	@sleep 10
	rm -rf var/filestorage var/blobstorage

clean:
	rm -f bin/* .installed.cfg

allclean: all-clean ## 	 Limpiar instalación

check-clean:
	test -z "$(shell git status --porcelain)" || (git status && echo && echo "Directorio de trabajo NO limpio." && false) && echo "Directorio de trabajo limpio."


####################################################################
# Entorno Desarrollo

devel: buildout-cfg-dev bin/buildout ## 	 Ejecutar buildout de ambiente de desarrollo
	bin/buildout -t 120

buildout-cfg-devel:
	printf "[buildout]\nextends = buildout.d/development.cfg\n#extends = buildout.d/staging.cfg\n#extends = buildout.d/production.cfg\n" > buildout.cfg

fg: devrun

devrun:
	sudo service nginx restart
	sudo service munin restart
	sudo service munin-node restart
	bin/supervisord
	bin/supervisorctl stop client1 client2
	bin/client-debug fg


####################################################################
# Entorno Pruebas

stag: buildout-cfg-stag bin/buildout ## 	 Ejecutar buildout de ambiente de pruebas
	bin/buildout -t 120

buildout-cfg-stag:
	printf "[buildout]\n#extends = buildout.d/development.cfg\nextends = buildout.d/staging.cfg\n#extends = buildout.d/production.cfg\n" > buildout.cfg


####################################################################
# Entorno Producción

prod: buildout-cfg-prod bin/buildout ## 	 Ejecutar buildout de ambiente de producción
	bin/buildout -t 120

buildout-cfg-prod:
	printf "[buildout]\n#extends = buildout.d/development.cfg\n#extends = buildout.d/staging.cfg\nextends = buildout.d/production.cfg\n" > buildout.cfg
