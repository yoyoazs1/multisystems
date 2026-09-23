# Multisystems Centrum v6.8 — Android

Projekt opakowuje aktualną wersję `MULTISYSTEMS_Centrum_v6_8.html` jako aplikację Android.

## Automatyczny APK na GitHub
Po wrzuceniu całej zawartości projektu do gałęzi `main` workflow **Build Multisystems APK**
uruchomi się automatycznie. Gotowy plik będzie w:
**Actions → Build Multisystems APK → Artifacts → Multisystems-v6.8-APK**.

## Dane
HTML działa wewnątrz Android WebView. Dane localStorage/IndexedDB pozostają lokalnie w pamięci aplikacji.

## OneDrive / Google Drive
Wersja v6.8 zawiera ekran/ustawienia przygotowujące integrację OAuth, ale pełna synchronizacja
wymaga osobnych danych OAuth (Client ID / konfiguracja aplikacji) dla Google i Microsoft.
Nie należy wpisywać sekretów OAuth bezpośrednio do repozytorium ani APK.
