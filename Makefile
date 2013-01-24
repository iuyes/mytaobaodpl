BOOTSTRAP = ./docs/assets/css/bootstrap.css
BOOTSTRAP_LESS = ./less/bootstrap.less
BOOTSTRAP_SCAFFOLD = ./docs/assets/css/bootstrap-scaffold.css
BOOTSTRAP_SCAFFOLD_LESS = ./less/scaffold.less
BOOTSTRAP_RESPONSIVE = ./docs/assets/css/bootstrap-responsive.css
BOOTSTRAP_RESPONSIVE_LESS = ./less/responsive.less
SNSASSETS = ~/a.tbcdn.cn/p/sns/1.1/dpl/
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


#
# BUILD DOCS
#

build:
	@echo "\n${HR}"
	@echo "Building Bootstrap..."
	@echo "${HR}\n"
	@recess --compile ${BOOTSTRAP_LESS} > ${BOOTSTRAP}
	@recess --compile ${BOOTSTRAP_RESPONSIVE_LESS} > ${BOOTSTRAP_RESPONSIVE}
	@recess --compile ${BOOTSTRAP_SCAFFOLD_LESS} > ${BOOTSTRAP_SCAFFOLD}
	@echo "Compiling LESS with Recess...               ${CHECK} Done"
	@node docs/build
	@echo "Bootstrap successfully built at ${DATE}."
	@echo "${HR}\n"
	@echo "Thanks for using Bootstrap,"

#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#

test:
	#jshint js/*.js --config js/.jshintrc
	#jshint js/tests/unit/*.js --config js/.jshintrc
	#node js/tests/server.js &
	#phantomjs js/tests/phantom.js "http://localhost:3000/js/tests"
	#kill -9 `cat js/tests/pid.txt`
	#rm js/tests/pid.txt

#
# BUILD SIMPLE BOOTSTRAP DIRECTORY
# recess & uglifyjs are required
#

buildbs:
	@cp ${BOOTSTRAP} ${SNSASSETS} 
	@cp ${BOOTSTRAP_RESPONSIVE} ${SNSASSETS}
	@cp ${BOOTSTRAP_SCAFFOLD} ${SNSASSETS}
	@echo "successfully copy file to sns"

#
# MAKE FOR GH-PAGES 4 FAT & MDO ONLY (O_O  )
#

gh-pages: bootstrap docs
	rm -f docs/assets/bootstrap.zip
	zip -r docs/assets/bootstrap.zip bootstrap
	rm -r bootstrap
	rm -f ../bootstrap-gh-pages/assets/bootstrap.zip
	node docs/build production
	cp -r docs/* ../bootstrap-gh-pages

#
# WATCH LESS FILES
#

watch:
	echo "Watching less files..."; \
	watchr -e "watch('less/.*\.less') { system 'make buildbs' }"

#
# 监听less文件的改变，然后执行 make buildbs
#
watchless:
	@node lessWatch.js

.PHONY: docs watch gh-pages
