all: build

build:
	swift build

test: build
	swift test

docs:
	swift package generate-xcodeproj
	jazzy --clean \
		--author "Junfeng Li" \
		--author_url https://github.com/autozimu \
		--github_url https://github.com/autozimu/Nanomsg.swift \
		--github-file-prefix https://github.com/autozimu/Nanomsg.swift/blob/master

gh-pages: docs
	ghp-import -n -p docs

clean:
	swift build --clean
	rm -rf build
	rm -rf docs

.PHONY: build test docs gh-pages clean
