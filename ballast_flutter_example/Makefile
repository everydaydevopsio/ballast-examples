FLUTTER_HOME := /home/marka/development/flutter
FLUTTER := "$(FLUTTER_HOME)/bin/flutter"
FLUTTER_REQUIRED_VERSION := 3.44.8

ANDROID_SDK_ROOT ?= $(or $(ANDROID_HOME),/opt/android-sdk)
SDKMANAGER := $(ANDROID_SDK_ROOT)/cmdline-tools/latest/bin/sdkmanager
AVDMANAGER := $(ANDROID_SDK_ROOT)/cmdline-tools/latest/bin/avdmanager
REQUIRED_NDK := 27.0.12077973
REQUIRED_BUILD_TOOLS := 34.0.0
REQUIRED_CMAKE := 3.22.1
ANDROID_AVD_NAME := flutter_dev
ANDROID_API_LEVEL := 35
ANDROID_AVD_DEVICE := pixel_6
ANDROID_SYSTEM_IMAGE := system-images;android-$(ANDROID_API_LEVEL);google_apis;x86_64

run-ios: check-flutter-version
	$(FLUTTER) run -d ios

run-android: check-flutter-version check-android-sdk
	@if ! adb devices | grep -q "^emulator"; then \
		echo "No emulator running, launching $(ANDROID_AVD_NAME)..."; \
		$(FLUTTER) emulators --launch $(ANDROID_AVD_NAME); \
		echo "Waiting for emulator to boot..."; \
		adb -e wait-for-device && adb -e shell 'while [ "$$(getprop sys.boot_completed)" != "1" ]; do sleep 2; done'; \
		echo "Emulator ready."; \
	fi
	$(FLUTTER) run -d emulator

analyze: check-flutter-version
	$(FLUTTER) analyze

test: check-flutter-version
	$(FLUTTER) test

integration: check-flutter-version
	$(FLUTTER) test integration_test


upgrade: check-flutter-version
	$(FLUTTER) pub upgrade

upgrade-check: check-flutter-version
	$(FLUTTER) pub get

check-android-sdk:
	@if [ ! -f "$(ANDROID_SDK_ROOT)/ndk/$(REQUIRED_NDK)/source.properties" ]; then \
		echo "NDK $(REQUIRED_NDK) missing or incomplete, installing..."; \
		$(SDKMANAGER) "ndk;$(REQUIRED_NDK)"; \
	else \
		echo "NDK $(REQUIRED_NDK) ok"; \
	fi
	@if [ ! -d "$(ANDROID_SDK_ROOT)/build-tools/$(REQUIRED_BUILD_TOOLS)" ]; then \
		echo "Build-Tools $(REQUIRED_BUILD_TOOLS) missing, installing..."; \
		$(SDKMANAGER) "build-tools;$(REQUIRED_BUILD_TOOLS)"; \
	else \
		echo "Build-Tools $(REQUIRED_BUILD_TOOLS) ok"; \
	fi
	@if [ ! -d "$(ANDROID_SDK_ROOT)/cmake/$(REQUIRED_CMAKE)" ]; then \
		echo "CMake $(REQUIRED_CMAKE) missing, installing..."; \
		$(SDKMANAGER) "cmake;$(REQUIRED_CMAKE)"; \
	else \
		echo "CMake $(REQUIRED_CMAKE) ok"; \
	fi

.PHONY: check-android-sdk

setup-emulator:
	@if $(AVDMANAGER) list avd | grep -q "Name: $(ANDROID_AVD_NAME)"; then \
		echo "Emulator '$(ANDROID_AVD_NAME)' already exists"; \
	else \
		echo "Installing system image $(ANDROID_SYSTEM_IMAGE)..."; \
		$(SDKMANAGER) "$(ANDROID_SYSTEM_IMAGE)"; \
		echo "Creating emulator '$(ANDROID_AVD_NAME)'..."; \
		echo no | $(AVDMANAGER) create avd --name "$(ANDROID_AVD_NAME)" --package "$(ANDROID_SYSTEM_IMAGE)" --device "$(ANDROID_AVD_DEVICE)"; \
	fi

.PHONY: setup-emulator

check-flutter-version:
	@ACTUAL=$$($(FLUTTER) --version 2>&1 | awk '/^Flutter [0-9]/{print $$2; exit}'); \
	if [ -z "$$ACTUAL" ]; then \
		echo "ERROR: Could not determine Flutter version at $(FLUTTER_HOME)"; exit 1; \
	fi; \
	echo "  Detected Flutter $$ACTUAL (required: >=$(FLUTTER_REQUIRED_VERSION))"; \
	awk -v a="$$ACTUAL" -v r="$(FLUTTER_REQUIRED_VERSION)" 'BEGIN{split(a,av,".");split(r,rv,".");for(i=1;i<=3;i++){sub(/[^0-9].*/,"",av[i]);sub(/[^0-9].*/,"",rv[i])};if(av[1]+0>rv[1]+0)exit 0;if(av[1]+0<rv[1]+0)exit 1;if(av[2]+0>rv[2]+0)exit 0;if(av[2]+0<rv[2]+0)exit 1;if(av[3]+0>=rv[3]+0)exit 0;exit 1}' /dev/null || \
	{ echo "ERROR: Flutter $$ACTUAL does not satisfy >=$$FLUTTER_REQUIRED_VERSION"; exit 1; }

.PHONY: check-flutter-version
