# RTSP Streamer with PiP & Recording

A Flutter mobile app for streaming RTSP video feeds with advanced features such as Picture-in-Picture (PiP) mode and recording functionality.

## Overview

This project demonstrates how to build a robust RTSP streaming app using Flutter. It leverages:
- **flutter_vlc_player:** For hardware-accelerated video streaming.
- **android_pip:** To enable Picture-in-Picture mode on Android devices.
- A modular code structure that cleanly separates features into multiple Dart files.

## Features

- **RTSP Streaming:**  
  Stream live video feeds from any RTSP URL using the VLC player for Flutter.

- **Picture-in-Picture (PiP) Mode:**  
  Keep your stream visible in a small window while multitasking.

- **Recording Support:**  
  Capture and record the streamed video (see integrated recording logic).

- **Responsive UI:**  
  A Material Design-based interface with smooth transitions and simple controls.

## Project Structure

- **main.dart:**  
  The entry point for the app, setting up the basic Material design app.

- **home_screen.dart:**  
  A home screen for entering the RTSP URL and navigating to the stream.

- **rtsp.dart:**  
  Core streaming logic integrating the VLC player and PiP functionality.

- **pip_screen.dart:**  
  A dedicated screen layout that supports Picture-in-Picture mode.

- **stream_app.dart:**  
  Another implementation of the streaming screen for various display modes.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev) installed.
- Android device/emulator (for testing PiP functionality; PiP is typically Android specific).
- A valid RTSP URL for testing the stream.

### Installation

1. **Clone the Repository:**
   ```bash
   git clone <repository_url>
   cd <repository_directory>
2. **Install Dependencies:**
   ```bash
   flutter pub get
3. **Run the App:**
   ```bash
   flutter run
