# Aplikacja Magic Flashcards

Aplikacja mobilna do nauki w formie fiszek. Umożliwia tworzenie własnych zestawów fiszek, przeglądanie przykładowych zestawów oraz naukę w trybie przeglądu kart. Projekt stworzony we Flutterze z lokalną bazą danych SQLite.

---

## Opis projektu

**Magic Flashcards** to aplikacja edukacyjna pozwalająca użytkownikowi:

- przeglądać gotowe zestawy fiszek (np. stolice Europy),
- tworzyć własne zestawy i dodawać do nich fiszki,
- uczyć się z fiszek w specjalnym trybie nauki,
- zarządzać własnymi zestawami (dodawanie, usuwanie, przeglądanie fiszek).

Nie wymaga rejestracji konta do podstawowego działania. Całość działa lokalnie na urządzeniu.

---

## Technologie

| Technologia       | Opis                                |
|-------------------|-------------------------------------|
| Flutter           | Framework UI                        |
| Dart              | Język programowania                 |
| SQLite            | Lokalna baza danych                 |
| sqflite           | Obsługa SQLite we Flutterze         |
| path_provider     | Dostęp do ścieżek systemowych       |
| Android Emulator  | Testowanie na wirtualnym urządzeniu |

---

## Funkcjonalności

### 🎯 Gotowe zestawy fiszek

Po uruchomieniu aplikacji użytkownik widzi 3 gotowe zestawy:
- Stolice Europy
- Kraj – Kontynent
- Stolice Azji

Każdy zestaw zawiera 10 przykładowych fiszek.

### 📁 Tworzenie własnych zestawów

- Użytkownik może utworzyć maksymalnie 10 własnych zestawów.
- Zestaw posiada nazwę.
- Po utworzeniu zestawu użytkownik może dodawać fiszki.

### 🧠 Tryb nauki

- Tryb nauki pozwala przeglądać fiszki z danego zestawu.
- Użytkownik może odkrywać odpowiedzi, przechodzić do następnej i poprzedniej fiszki.
- Po dotarciu do końca zestawu, aplikacja wraca do pierwszej karty.

### 🗑️ Zarządzanie zestawami i fiszkami

- Możliwość usuwania całych zestawów.
- Możliwość usuwania pojedynczych fiszek z zestawu.

---

## Jak uruchomić aplikację

1. **Zainstaluj Fluttera** – https://flutter.dev/docs/get-started/install
2. **Zainstaluj Android Studio + Android SDK + Emulator**
3. W terminalu uruchom projekt:

```bash
flutter pub get
flutter run
```

> 💡 Jeśli nie masz fizycznego urządzenia, możesz użyć Android Emulatora (Pixel 6, API 34 lub wyższy).

---

## Demo

👉 [Zobacz demo aplikacji](demo.mp4)  (Trzeba kliknąc view raw aby pobrać film)


---

## Autorzy

Przemysław Orzechowski
