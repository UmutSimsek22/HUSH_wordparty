---
name: Hush Retro Warm Arcade
description: High energy party game design with warm charcoal dark mode, flame red, ocean blue, bright gold, and amber. Free of purple and green to ensure full copyright independence.
colors:
  background: "#121820"
  surface: "#1A222D"
  surface-light: "#25303F"
  border: "#2C394B"
  text-primary: "#F8FAFC"
  text-secondary: "#94A3B8"
  text-muted: "#64748B"
  
  # Team colors (Telif-safe warm arcade palette)
  team-red: "#FF4D4D"       # Ateş Kırmızısı (Red Team)
  team-blue: "#00A8FF"      # Okyanus Mavisi (Blue Team)
  team-gold: "#FFC048"      # Parlak Altın Sarısı (Gold Team)
  team-amber: "#FF793F"     # Sıcak Kehribar / Turuncu (Amber Team)
  
  # Action colors
  action-correct: "#00A8FF" # Doğru (+1 Puan) - Cyber Ocean Blue
  action-hush: "#FF4D4D"    # HUSH! (-1 Ceza) - Flame Red
  action-pass: "#FF793F"    # Pas (0 Puan) - Warm Amber
  timer-ring: "#FFC048"     # Geri Sayım Halkası - Bright Gold
typography:
  font-family-primary: "Roboto, -apple-system, sans-serif"
  size-title: "36px"
  size-target-word: "32px"
  size-forbidden-word: "20px"
  size-timer: "40px"
  size-button: "17px"
  size-body: "15px"
rounded:
  sm: "8px"
  md: "16px"
  lg: "24px"
  full: "9999px"
---

# HUSH! (Hush: Word Party) - Design Specification

## Overview
A modern, energetic party game interface designed for fast-paced single-device mobile gaming. Features high legibility, tactile feedback, bold card contrast, and vibrant team color distinctions. Completely independent of any trademarked visual motifs.

## Colors
- **Background (`#121820`)**: Deep charcoal black/navy providing optimal visual comfort and OLED contrast.
- **Surface (`#1A222D`)**: Card containers and elevated panels.
- **Team Accents**:
  - **Ateş Kırmızısı (`#FF4D4D`)**: Team Red & Penalty indicators.
  - **Okyanus Mavisi (`#00A8FF`)**: Team Blue & Positive action indicators.
  - **Parlak Altın (`#FFC048`)**: Team Gold, Winner awards, and Timer ring.
  - **Sıcak Kehribar (`#FF793F`)**: Team Amber & Pass action.

## Layout & Components
- **Welcome Menu Screen**: Animated glowing HUSH! logo, party word tagline, large navigation cards with icons (Oyuna Başla, Nasıl Oynanır?, Ayarlar, Çıkış).
- **Gameplay Card**: Centered card with rounded corners (24px) and subtle neon border glow.
- **Action Dock**: Three thumb-friendly buttons (Pas, HUSH!, Doğru) with distinct icons and score badges.
- **Circular Progress Timer**: Glowing gold countdown circle with audible ticks during the final 5 seconds.
- **Leaderboard & Player Matrix**: Clear ranking table displaying Doğru, HUSH!, Pas, İsabet Oranı (%) and Net Puan.
