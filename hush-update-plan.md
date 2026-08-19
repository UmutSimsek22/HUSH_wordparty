# 📋 Project Plan: HUSH! Word Party Overhaul (`hush-update-plan.md`)

> **Task Slug:** `hush-update-plan`  
> **Project Type:** MOBILE (Flutter - Cross-platform Android/iOS/Web/Desktop)  
> **Primary Agent:** `mobile-developer` / `project-planner`  
> **Skills:** `clean-code`, `mobile-design`, `design-spec`, `testing-patterns`  
> **Date:** 2026-08-19  

---

## 🎯 Overview & Objectives

This plan details the comprehensive update and visual overhaul of the **HUSH! (Hush: Word Party)** game. The updates include:
1. **Icon & Brand Refresh:** Cropping and applying the new vintage cartoon "HUSH!" mascot icon.
2. **Theme Overhaul:** Transitioning from the current neon warm dark theme to a **Black & White Vintage Cartoon / Retro Pixel Art** style inspired by 1930s rubber-hose animation and retro pixel arcade visuals.
3. **Team Setup & 5-Color Logic:** Expanding team colors to 5 (Red, Blue, Yellow, Green, Pink) and fixing duplicate color allocation bugs.
4. **Gameplay & Timer Upgrades:** Adding a 10-second round timer, back navigation buttons, and an in-game pause/abandon modal (freezing countdown).
5. **Sound System Enhancements:** Updating correct/pass audio effects with assets from `newsoundeffectshere/` and refining the "Time's Up" audio tone.
6. **Multi-Stage Game Over Reveal:** Replacing the static stats screen with a dramatic multi-stage reveal flow (Game Over -> Drumroll -> Champion Team + Confetti -> MVP Reveal with Crown -> Detailed Stats Matrix).
7. **Splash Intro & Credits:** Adding a 3-4 second fade-in "developed by Constant Variables" splash screen and a dedicated Credits modal.

---

## 📐 Design & Visual Specification (Vintage Rubber-Hose / Retro Pixel Art)

- **Background:** Deep Ink Black (`#121212`) & Vintage Off-White / Cream (`#F4F1EA`)
- **Card Surfaces:** High contrast cream cards with bold pixel/vintage borders (`#2D2D2D`, 3px stroke)
- **Team Colors (5 Presets):**
  - ❤️ **Red:** `#FF3B30`
  - 💙 **Blue:** `#007AFF`
  - 💛 **Yellow:** `#FFCC00`
  - 💚 **Green:** `#34C759`
  - 🩷 **Pink:** `#FF2D55`
- **Typography:** Bold retro arcade / typewriter headers with high legibility.

---

## 🗓️ Task Breakdown

### Phase 1: Splash Screen & Navigation Infrastructure
- **Task 1.1:** Create `SplashScreen` (`lib/screens/splash_screen.dart`)
  - **INPUT:** App startup in `lib/main.dart`
  - **OUTPUT:** 3-4s fade-in animation on black background showing `"developed by Constant Variables"`, then smoothly transitioning to `WelcomeScreen`.
  - **VERIFY:** App launches into splash screen, animates, and auto-navigates cleanly.

- **Task 1.2:** Add Back Navigation Support
  - **INPUT:** `TeamSetupScreen`, `GameSettingsScreen`, `RoundSummaryScreen`
  - **OUTPUT:** App bar leading back button / custom retro back button allowing users to return to previous screens.
  - **VERIFY:** Clicking back returns to previous screen without state corruption.

- **Task 1.3:** Initialize iOS Platform Configuration
  - **INPUT:** `hush_app/` Flutter project
  - **OUTPUT:** Run `flutter create --platforms=ios .` to generate `hush_app/ios/` configuration files (Runner workspace, Info.plist, Podfile).
  - **VERIFY:** `hush_app/ios/` directory is created and configured.

### Phase 2: Icon & Asset Processing
- **Task 2.1:** Crop & Generate App Icon
  - **INPUT:** `media_1787170355725.jpg`
  - **OUTPUT:** Cropped square mascot image without white side margins; generated launcher icon assets for Android/iOS/Web.
  - **VERIFY:** Icon is centered, cropped cleanly, and placed in `hush_app/assets/images/app_icon.png`.

- **Task 2.2:** Update Sound Assets & Mapping
  - **INPUT:** `newsoundeffectshere/newcorrect.wav`, `newsoundeffectshere/newpass.wav`
  - **OUTPUT:** 
    - Replace `assets/sounds/correct.wav` with `newcorrect.wav`.
    - Update `assets/sounds/pass.wav` with `newpass.wav`.
    - Reassign current pass sound effect to HUSH! (wrong answer) action sound.
    - Update `assets/sounds/timeup.wav` to a distinct "Time's Up" chime instead of error buzzer.
  - **VERIFY:** Audio triggers produce correct sounds across Web and Mobile.

### Phase 3: Welcome Screen & Credits
- **Task 3.1:** Update Welcome Screen Subtitle & Layout
  - **INPUT:** `lib/screens/welcome_screen.dart`
  - **OUTPUT:** Update text under "Oyuna Başla" to `"Takımlarınızı kurun ve oyuna başlayın"`.
  - **VERIFY:** Subtitle text matches exact user wording.

- **Task 3.2:** Implement Credits Button & Modal
  - **INPUT:** `lib/screens/welcome_screen.dart`
  - **OUTPUT:** Add "Credits" button above "Çıkış". Display dialog/modal with Developer Name (**Umut Şimşek**), GitHub link (`https://github.com/UmutSimsek22/HUSH_wordparty`), and message `"Beni bu yolda destekleyen herkese teşekkürler"`.
  - **VERIFY:** Modal displays all required information and closes cleanly.

### Phase 4: Team Setup & Color Selection Logic (5 Colors)
- **Task 4.1:** Update Team Colors & Model
  - **INPUT:** `lib/models/team.dart` & `lib/providers/game_provider.dart`
  - **OUTPUT:** Expand team color palette to 5 options (Red, Blue, Yellow, Green, Pink).
  - **VERIFY:** Teams can select any of the 5 colors.

- **Task 4.2:** Fix Team Selection & Duplicate Color Bug
  - **INPUT:** `lib/screens/team_setup_screen.dart`
  - **OUTPUT:** Prevent duplicate team color allocation when removing/adding teams up to 4 teams max.
  - **VERIFY:** Removing default teams and adding new teams correctly cycles available unassigned colors.

### Phase 5: Game Settings & Timer Upgrade
- **Task 5.1:** Add 10-Second Timer Option
  - **INPUT:** `lib/models/game_settings.dart` & `lib/screens/game_settings_screen.dart`
  - **OUTPUT:** Include `10` seconds option alongside 30, 45, 60, 90, 120s.
  - **VERIFY:** 10s option can be selected and runs a 10s turn timer.

- **Task 5.2:** In-Game Pause & Abandon Game Modal
  - **INPUT:** `lib/screens/gameplay_screen.dart` & `lib/providers/game_provider.dart`
  - **OUTPUT:** Add pause/exit button in `GameplayScreen`. Show confirmation modal `"Oyunu bozmak istediğinize emin misiniz?"`. Freeze turn timer while modal is open. Resume timer if canceled, return to `WelcomeScreen` if confirmed.
  - **VERIFY:** Timer pauses when modal opens and resumes/resets correctly.

### Phase 6: Multi-Stage Game Over Reveal Flow
- **Task 6.1:** Build Multi-Stage `GameOverScreen` (`lib/screens/game_over_screen.dart`)
  - **INPUT:** End of final round in `GameProvider`
  - **OUTPUT:**
    - **Stage 1 (Suspense):** "OYUN BİTTİ!" banner with suspenseful theme and drumroll sound effect.
    - **Stage 2 (Winner Announcement):** Reveal winning team with fanfare sound + confetti/balloon animation.
    - **Stage 3 (MVP Reveal):** Brief delay/effect -> Reveal MVP player with crown icon `👑` above name (e.g., `👑` above `UMUT`) + celebration sound.
    - **Stage 4 (Detailed Player Matrix):** Tap to open individual player stats breakdown.
    - **Stage 5 (Full Team Summary & Rematch):** Complete team leaderboard table and Rematch button.
  - **VERIFY:** Stage progression works sequentially with correct audio and animation timing.

### Phase 7: Theme & Styling Overhaul (Vintage Retro Pixel Art)
- **Task 7.1:** Apply Vintage Black & White Retro Theme across all screens
  - **INPUT:** `DESIGN.md` & Flutter app theme widgets
  - **OUTPUT:** Retro pixel art borders, high-contrast monochrome cards, vintage mascot accents, custom retro button styles.
  - **VERIFY:** Complete visual consistency across all screens without residual modern AI aesthetics.

---

## 🔍 Phase X: Final Verification Checklist

- [x] All unit and widget tests pass (`flutter test`).
- [x] Image cropped cleanly and icon asset updated (`assets/images/app_icon.png`).
- [x] 5 team colors work without duplicate color assignments.
- [x] 10-second turn option functions properly.
- [x] In-game pause freezes timer accurately.
- [x] Multi-stage Game Over reveal sequence executes smoothly.
- [x] Splash screen and Credits modal function as expected.
- [x] Vintage Black & White Retro Pixel Art theme is consistently applied.
- [x] iOS platform configuration added to `hush_app/ios/`.

## ✅ PHASE X COMPLETE
- Code Quality & Syntax: ✅ Pass (100% Clean)
- iOS Configuration: ✅ Initialized
- Commit/Push Policy: ✅ Respected (Changes kept local per user request)
- Date: 2026-08-19
