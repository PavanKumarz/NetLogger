#  NetLogger

NetLogger is a Flutter-based network monitoring application that measures **download throughput**, **upload throughput**, and **latency (ping)** by communicating with a custom Node.js server.

Unlike a one-time speed test, NetLogger stores every test locally, allowing users to monitor network performance over time through historical records and visualizations.

> **Note:** NetLogger measures the throughput between the client device and the configured backend server. The results reflect the real-world performance of the active internet connection (Wi-Fi or Mobile Data) to that server.

#  Features

*  Download Throughput Test
*  Upload Throughput Test
*  Average Ping Measurement
*  Detect Connected Wi-Fi Network
*  Store Test History using SQLite
*  Interactive History Chart
*  Background Speed Testing
*  Local Data Persistence
*  Date & Time for Every Test
*  Custom Node.js Backend
*  Material Design UI
*  Android Support

---

#  Architecture

```text
                Flutter App
                     │
        ┌────────────┼────────────┐
        │            │            │
        ▼            ▼            ▼
    API Service   SQLite DB   Background Service
        │            │
        ▼            │
    Node.js API      │
        │            │
   ┌────┼────┐        │
   │    │    │        │
 /ping /download /upload
        │
        ▼
 PostgreSQL (Optional Sync)
```

---

#  Built With

## Frontend

* Flutter
* Dart

## Backend

* Node.js
* Express.js

## Local Database

* SQLite (sqflite)

## Networking

* http

## Storage

* SharedPreferences

## Charts

* fl_chart

## Utilities

* intl
* path_provider

## Device Information

* network_info_plus
* permission_handler

---

# Project Structure

```text
lib/
│
├── models/
├── services/
│   ├── api_service.dart
│   ├── db_service.dart
│   └── background_service.dart
│
├── providers/
├── screens/
├── widgets/
├── database/
└── main.dart
```

---

#  How It Works

NetLogger measures network performance by transferring data between the mobile device and a custom Node.js server.

##  Download Test

1. The app requests a file from the backend server.
2. It measures the total download time.
3. It calculates download throughput.

---

##  Upload Test

1. The app generates a payload.
2. Uploads it to the backend server.
3. Measures upload duration.
4. Calculates upload throughput.

---

##  Ping Test

1. Sends multiple lightweight HTTP requests.
2. Measures round-trip time (RTT).
3. Calculates the average latency.

---

#  Test History

Every completed test is stored locally using SQLite.

Each record contains:

* Network Name
* Download Speed
* Upload Speed
* Ping
* Date
* Time

Users can review previous tests to monitor network performance over time.

---

#  Backend API

NetLogger communicates with a custom Node.js backend.

### GET `/ping`

Returns a lightweight response used for latency measurement.

### GET `/download`

Returns a downloadable payload used for download throughput calculation.

### POST `/upload`

Receives uploaded data and is used for upload throughput calculation.

---
