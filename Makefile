init: 
	dart pub get
	dart run build_runner build --delete-conflicting-outputs

gen:
	dart run build_runner build --delete-conflicting-outputs

dev:
	dart_frog dev

clean:
	rm -rf .dart_tool/ build/
	find . -name "*.mocks.dart" -delete
	find . -name "*.g.dart" -delete
	find . -name "*.freezed.dart" -delete
	dart run build_runner clean