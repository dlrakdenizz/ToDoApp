# ToDoApp

Firebase destekli, kullanıcı kayıt/giriş özellikleri bulunan basit bir iOS görev takip uygulaması. Swift ve UIKit kullanılarak geliştirilmiştir.

## Özellikler

- 🔐 Kullanıcı kimlik doğrulama (Kayıt olma ve giriş yapma)
- 👤 Profil yönetimi
- ✅ Görev ekleme ve silme
- 📅 Tamamlanan görevleri görüntüleme
- 🖼️ Profil fotoğrafı yükleme

## Gereksinimler

- iOS 13.0+
- Xcode 13.0+
- Swift 5.0+
- Firebase hesabı

## Kurulum

1. Projeyi klonlayın:
bash
git clone https://github.com/your-username/ToDoApp.git
cd ToDoApp


2. CocoaPods bağımlılıklarını yükleyin:
bash
pod install


3. Firebase projenizi oluşturun:
   - [Firebase Console](https://console.firebase.google.com/)'a gidin
   - Yeni bir proje oluşturun
   - iOS uygulamanızı Firebase'e ekleyin
   - GoogleService-Info.plist dosyasını indirin

4. GoogleService-Info.plist dosyasını projenize ekleyin:
   - İndirdiğiniz GoogleService-Info.plist dosyasını Xcode projenize sürükleyin
   - "Copy items if needed" seçeneğini işaretleyin
   - "Add to targets" kısmında ToDoApp'i seçin

5. Projeyi Xcode ile açın:
bash
open ToDoApp.xcworkspace


## Firebase Kurulumu

1. Firebase Console'da Authentication'ı etkinleştirin:
   - Email/Password sign-in metodunu aktif edin

2. Firestore Database'i etkinleştirin:
   - Test modunda başlatın veya güvenlik kurallarını yapılandırın

3. Storage'ı etkinleştirin:
   - Profil fotoğrafları için gerekli kuralları ayarlayın

## Kullanım

1. Uygulamayı başlatın
2. Kayıt olun veya giriş yapın
3. Profil fotoğrafı ekleyin
4. Görevlerinizi ekleyin ve yönetin

Proje Linki: [https://github.com/your-username/ToDoApp](https://github.com/your-username/ToDoApp)
