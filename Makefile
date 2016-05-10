all:
	swift build

doc:
	swift build --generate-xcodeproj
	jazzy

clean:
	swift build --clean
