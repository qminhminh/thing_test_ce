# Privacy Manifest Fixes for App Store Connect

## Các vấn đề đã được sửa

### 1. ITMS-91061: Missing privacy manifest
- **Vấn đề**: Các SDK `geolocator_apple` và `image_picker_ios` thiếu privacy manifest
- **Giải pháp**: 
  - Cập nhật `geolocator_apple` lên phiên bản `^2.3.13`
  - Cập nhật `image_picker_ios` lên phiên bản `^0.8.12+2`
  - Sử dụng `dependency_overrides` trong `pubspec.yaml` để đảm bảo sử dụng phiên bản mới nhất

### 2. ITMS-91055: Invalid API reason declaration
- **Vấn đề**: Sử dụng mã lý do không hợp lệ `CA92.1`
- **Giải pháp**: 
  - Thay thế `CA92.1` bằng `35F9.1` cho UserDefaults
  - Thay thế `CA92.1` bằng `E174.1` cho FileTimestamp, SystemBootTime, và DiskSpace

### 3. ITMS-91054: Invalid API category declaration
- **Vấn đề**: Sử dụng các API category không hợp lệ
- **Giải pháp**: 
  - Loại bỏ các API category không hợp lệ:
    - `NSPrivacyAccessedAPICategoryDeviceIdentifier`
    - `NSPrivacyAccessedAPICategoryLocation`
    - `NSPrivacyAccessedAPICategoryPhotoLibrary`
    - `NSPrivacyAccessedAPICategoryCameraCapture`

## Các thay đổi đã thực hiện

### 1. Cập nhật pubspec.yaml
```yaml
dependency_overrides:
  geolocator_apple: ^2.3.13
  image_picker_ios: ^0.8.12+2
```

### 2. Sửa file PrivacyInfo.xcprivacy
- Sử dụng mã lý do hợp lệ cho các API
- Loại bỏ các API category không hợp lệ
- Giữ nguyên các thông tin về dữ liệu được thu thập

### 3. Cập nhật version
- Tăng version từ `1.1.0` lên `1.1.1`

## Cách build và submit

1. Chạy `flutter clean`
2. Chạy `flutter pub get`
3. Build cho iOS: `flutter build ios`
4. Archive và upload lên App Store Connect

## Lưu ý
- Các SDK bên thứ ba đã được cập nhật lên phiên bản mới nhất có privacy manifest
- File PrivacyInfo.xcprivacy đã được sửa để tuân thủ các yêu cầu của Apple
- Version đã được tăng để có thể submit build mới 