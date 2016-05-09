all:
	swift build

doc:
	swift build --generate-xcodeproj
	jazzy
