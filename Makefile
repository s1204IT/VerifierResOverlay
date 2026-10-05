APK_NAME := VerifierResOverlay
SDK_BASE := 37.2
SDK_CODE := 37
SDK_NAME := 17

all: clean build

clean:
	@echo "Cleaning..."
	@rm -f $(APK_NAME).apk

build:
	@echo "Packaging..."
	@aapt package -M data/AndroidManifest.xml -S data/res --min-sdk-version $(SDK_CODE) --target-sdk-version $(SDK_CODE) --version-code $(SDK_CODE) --version-name $(SDK_NAME) -I $$ANDROID_SDK_ROOT/platforms/android-$(SDK_BASE)/android.jar -F $(APK_NAME)-unaligned.apk
	@echo "Aligning..."
	@zipalign 4 $(APK_NAME)-unaligned.apk $(APK_NAME).apk
	@rm -f $(APK_NAME)-unaligned.apk
	@echo "Signing..."
	@apksigner sign --cert data/cert/cert.pem --key data/cert/cert.pk8 $(APK_NAME).apk
	@rm -f $(APK_NAME).apk.idsig
	@echo "\nDone: $(APK_NAME).apk"
