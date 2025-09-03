ifeq ($(OS),Windows_NT)
	COPY = copy
else 
	COPY = cp
endif

first_run:
	fvm use 3.35.2
	make create-env-filesmake 
	make get-dep
	make build-runner-delete
	make gen-l10n

rebuild:
	make clean
	make get-dep
	make build-runner-delete
	make gen-l10n
	
create-env-files:
	@echo "Using $(COPY) command..."
	@$(COPY) assets/env/.env.example assets/env/.env
	@$(COPY) assets/env/.env.example assets/env/.env.dev

clean:
	fvm flutter clean

get-dep:
	fvm flutter pub get

upgrade-dep:
	fvm flutter pub upgrade --major-versions

build-runner:
	fvm flutter pub run build_runner build

watch-runner:
	fvm flutter pub run build_runner watch

build-runner-delete:
	fvm flutter pub run build_runner build --delete-conflicting-outputs

watch-runner-delete:
	fvm flutter pub run build_runner watch --delete-conflicting-outputs

gen-l10n:
	fvm flutter gen-l10n

gen-flavor:
	fvm flutter pub run flutter_flavorizr

build-apk-dev:
	fvm flutter build apk --flavor dev -t lib/main.dart --dart-define=FLAVOR=dev

build-apk-prod:
	fvm flutter build apk --flavor prod -t lib/main.dart --dart-define=FLAVOR=prod

build-appbundle-dev:
	fvm flutter build appbundle --flavor dev -t lib/main.dart --dart-define=FLAVOR=dev

build-appbundle-prod:
	fvm flutter build appbundle --flavor prod -t lib/main.dart --dart-define=FLAVOR=prod

build-ipa-dev:
	fvm flutter build ipa --flavor dev -t lib/main.dart --dart-define=FLAVOR=dev

build-ipa-prod:
	fvm flutter build ipa --flavor prod -t lib/main.dart --dart-define=FLAVOR=prod


