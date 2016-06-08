all:
	swift build

doc:
	swift package generate-xcodeproj
	jazzy --clean \
		--author "Junfeng (Jeff) Li" \
		--author_url https://github.com/autozimu \
		--github_url https://github.com/autozimu/Nanomsg.swift \
		--github-file-prefix https://github.com/autozimu/Nanomsg.swift/blob/master

gh-pages: doc
	gh-pages --dist docs

clean:
	swift build --clean
