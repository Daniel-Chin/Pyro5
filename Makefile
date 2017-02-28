.PHONY: all sdist wheel docs install upload upload_docs clean test
PYTHON=python3

all:
	@echo "targets include sdist, wheel, docs, upload, upload_docs, install, clean"

sdist: 
	$(PYTHON) setup.py sdist
	@echo "Look in the dist/ directory"

wheel: 
	$(PYTHON) setup.py bdist_wheel
	@echo "Look in the dist/ directory"

docs:
	$(PYTHON) setup.py build_sphinx

upload: upload_docs
	$(PYTHON) setup.py sdist bdist_wheel upload
	@echo "Don't forget to package and upload the documentation!"
	
upload_docs: docs
	#  $(PYTHON) setup.py upload_docs --upload-dir=build/sphinx/html
	rm -f build/sphinx/docs.zip
	cd build/sphinx/html && zip -qr ../docs.zip .
	@echo
	@echo "@todo the setuptools upload_docs command / pypi doc upload have problems lately."
	@echo "Upload build/sphinx/docs.zip manually at the bottom of this page:"
	@echo "https://pypi.python.org/pypi?:action=pkg_edit&name=Pyro5"

install:
	$(PYTHON) setup.py install

test:
	$(PYTHON) tests/run_testsuite.py

clean:
	@echo "Removing logfiles, .pyo/.pyc files..."
	find . -name __pycache__ -print0 | xargs -0 rm -rf
	find . -name \*.log -print0 | xargs -0  rm -f
	find . -name \*_URI -print0 | xargs -0  rm -f
	find . -name \*.pyo -print0 | xargs -0  rm -f
	find . -name \*.pyc -print0 | xargs -0  rm -f
	find . -name \*.class -print0 | xargs -0  rm -f
	find . -name \*.DS_Store -print0 | xargs -0  rm -f
	find . -name \.coverage -print0 | xargs -0  rm -f
	find . -name \coverage.xml -print0 | xargs -0  rm -f
	find . -name  '.#*' -print0 | xargs -0  rm -f
	find . -name  '#*#' -print0 | xargs -0  rm -f
	rm -f MANIFEST
	rm -rf build
	@echo "clean!"
