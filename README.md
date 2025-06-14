🚀 Found You App (Praca Inżynierska)
Projekt found_you_app to aplikacja mobilna stworzona w technologii Flutter w ramach pracy inżynierskiej. Poniższa instrukcja przeprowadzi Cię przez proces konfiguracji środowiska i uruchomienia aplikacji.

🛠️ Wymagania wstępne
Zanim zaczniesz, upewnij się, że na Twoim komputerze zainstalowane są następujące narzędzia:

Flutter SDK: Oficjalna instrukcja instalacji Fluttera

Android Studio: Pobierz Android Studio

Wtyczki Flutter i Dart dla Android Studio:

Otwórz Android Studio.

Przejdź do File > Settings > Plugins.

Wyszukaj i zainstaluj wtyczki Flutter oraz Dart.

Aby zweryfikować, czy Twoje środowisko jest poprawnie skonfigurowane, uruchom w terminalu komendę:

flutter doctor

Komenda ta sprawdzi stan Twojej instalacji i wskaże ewentualne problemy, które należy rozwiązać. Zwróć uwagę na komunikaty i upewnij się, że wszystkie kluczowe komponenty (oznaczone галочкой [✓]) są gotowe.

⚙️ Uruchamianie aplikacji w Android Studio
Postępuj zgodnie z poniższymi krokami, aby pobrać i uruchomić projekt na swoim komputerze.

1. Pobranie kodu źródłowego
Sklonuj repozytorium projektu na swój dysk lokalny za pomocą komendy git. Otwórz terminal i wpisz:

git clone <URL_GIT>
cd found_you_app


2. Otwarcie projektu w Android Studio
Uruchom Android Studio.

Na ekranie powitalnym wybierz opcję "Open" (lub File > Open jeśli masz już otwarty inny projekt).

Wskaż folder found_you_app, który został pobrany w poprzednim kroku i kliknij "Open".

3. Instalacja zależności
Po otwarciu projektu Android Studio powinien automatycznie wykryć, że jest to projekt Fluttera.

Poczekaj, aż program zindeksuje pliki.

W prawym górnym rogu powinien pojawić się przycisk "Pub get". Kliknij go, aby pobrać wszystkie wymagane pakiety zdefiniowane w pliku pubspec.yaml.

Jeśli powiadomienie się nie pojawi, możesz uruchomić ten proces ręcznie, otwierając terminal w Android Studio (View > Tool Windows > Terminal) i wpisując komendę:

flutter pub get

4. Konfiguracja urządzenia do uruchomienia
Masz dwie możliwości, aby uruchomić aplikację:

Emulator Androida:

W Android Studio przejdź do Tools > Device Manager.

Stwórz nowe wirtualne urządzenie (Create device) lub uruchom już istniejące, klikając ikonę ▶️.

Fizyczne urządzenie Android:

Włącz Opcje programistyczne oraz Debugowanie USB na swoim telefonie.

Zazwyczaj: Wejdź w Ustawienia > Informacje o telefonie i kliknij 7 razy w "Numer kompilacji". Następnie w Ustawienia > System > Opcje programistyczne włącz "Debugowanie USB".

Podłącz telefon do komputera za pomocą kabla USB.

Zatwierdź na telefonie prośbę o autoryzację debugowania z Twoim komputerem.

5. Uruchomienie aplikacji
Wybierz skonfigurowane urządzenie (emulator lub podłączony telefon) z listy dostępnych urządzeń, która znajduje się na głównym pasku narzędzi Android Studio.

Kliknij zieloną ikonę Run 'main.dart' (▶️) lub użyj skrótu klawiszowego Shift + F10.

Android Studio zbuduje aplikację i zainstaluje ją na wybranym urządzeniu. Pierwsze uruchomienie może potrwać kilka minut.

Gotowe! Aplikacja found_you_app powinna być teraz uruchomiona. 🎉
