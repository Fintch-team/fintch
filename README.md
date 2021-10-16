<h1 align="center">
  Fintch
</h1>
<p align="center">
  E-Wallet For School 
</p>
<p align="center">
  <a href="https://flutter.dev/"><img alt="Platform" src="https://img.shields.io/badge/platform-Flutter-blue.svg"></a>
  <a href="https://dart.dev/"><img alt="Dart" src="https://img.shields.io/badge/dart-2.12.2-blue.svg"></a>
  <a href="https://github.com/Adithya-13/MadeSubmsission/"><img alt="Star" src="https://img.shields.io/github/stars/Fintch-team/fintch"></a>
</p>

<p align="center">
  <img src="demo/thumbnail.png"/>
</p>

## Table of Contents
- [Introduction](#introduction)
- [Installation](#installation)
- [Demo](#demo)
- [Features](#features)
<!-- - [Tech Stack](#tech-stack)
- [Dependencies](#dependencies)
- [Screen](#screen)
- [Util Tasks](#util-tasks)
- [Future Feature](#future-feature)
- [Feedback from user](#feedback-from-user) -->

## Introduction

Fintch adalah sebuah aplikasi Digital Wallet Fintech yang menggantikan cara bertransaksi secara manual beralih ke arah yang lebih modern pada ranah sekolah. Fintch memudahkan untuk kegiatan transaksi dalam sekolah secara digital. Fintch membuat segala kegiatan transaksi tidak memerlukan uang fisik, melainkan uang digital (digital wallets). Fintch menggunakan sistem QR code untuk melakukan transaksi, just scan-pay-go.

Fintch menghadirkan 7 fitur utama, yaitu:

1. Pay
Pay merupakan Fitur yang memudahkan user dalam melakukan pembayaran yang ditujukan pada pengirim transaksi cukup dengan meng-scan barcode atau memasukkan jumlah nominal yang perlu dibayarkan.

2. Receive
Receive merupakan Fitur yang memudahkan user dalam menerima pembayaran yang ditujukan pada penerima transaksi dengan cara memberikan barcode untuk di-scan kepada pengirim transaksi.

3. Barrier Cash
Barrier cash adalah fitur untuk membatasi jumlah pengeluaran keuangan pada user, pada fitur ini user maupun orang tua user dapat mengatur dengan cara membatasi jumlah nominal pengeluaran baik perhari,perbulan, maupun perminggu yang akan sangat membantu menghemat keuangan user serta menghindari perilaku konsumtif.

4. Parenting
Parenting adalah sebuah fitur untuk memonitoring segala transaksi si user/siswa, agar setiap transaksi yang dilakukan oleh siswa, terdaftar disebuah database dan bisa dilihat oleh orang tua. Parenting juga memungkinkan orang tua mengatur barrier cash si user/siswa untuk mengatur jumlah maksimal pengeluarannya, dan juga bisa mentransfer Fintch Point nya ke si user/siswa.

5. History
History adalah fitur untuk men-tracking segala transaksi yang dilakukan oleh user, sehingga lebih tertulis dan user bisa melihatnya.

6. F-Wallet
F-Wallet (Fintch Wallet) merupakah salah satu fitur aplikasi FINTCH yang membantu dalam memanajemen keuangan user/siswa dengan cara bisa melihat pendapatan dan pengeluaran secara berkala serta user juga dapat mengelola dan mengatur keuangannya selama berada di sekolah.

7. F-Goals
F-Goals (Fintch Goals) merupakam fitur pada aplikasi FINTCH yang fokus dalam perencanaan keuangan, fitur ini dapat digunakan untuk menentukan tujuan dalam hal keinginan dan kebutuhan user selama di sekolah dari segi keuangan . Setelah itu, sistem akan mengakumulasikannya secara otomatis dan menampilkan jumlah target uang perharinya yang harus disimpan user agar tujuan tersebut bisa tercapai.

Fintch membutuhkan Top-up Saldo untuk merubah uang fisik menjadi Fintch Point lewat Payment Gateway Midtrans, yang nantinya Fintch Point bisa dipakai untuk segala kegiatan Transaksi disekolah, contohnya bayar parkir, membeli makanan atau minuman di kantin, membayar bulanan sekolah, dan lain sebagainya.
<!-- 
## Installation

Clone or Download and Open it into Android Studio, VSCode, or Other IDE / Text Editor
```
    https://github.com/Adithya-13/Flutask.git
```  
 -->
## Demo

![](demo/demo.gif?raw=true)

<!-- 
|Getting Started|Add Task|Update Task|Delete Task|
|--|--|--|--|
|![](demo/getting_started.gif?raw=true)|![](demo/add_task.gif?raw=true)|![](demo/update_task.gif?raw=true)|![](demo/delete_task.gif?raw=true)|

|Search Task|Detail Category|Calendar Task|
|--|--|--|
|![](demo/search_task.gif?raw=true)|![](demo/detail_category.gif?raw=true)|![](demo/calendar_task.gif?raw=true)| -->

## Features
- Pay
- Receive
- Barrier Cash
- History
- Parenting
- F-Wallet
- F-Goals

## Tech Stack
- BloC Architecture Pattern
- BloC State Management
<!-- - Moor Local Database -->
- Clean Architecture (data, domain, presentation)
<!-- - Custom Widget (Calendar and Time Picker) -->
<!-- 
## Dependencies
- [Equatable](https://pub.dev/packages/equatable)
- [RxDart](https://pub.dev/packages/rxdart)
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- [Logging](https://pub.dev/packages/logging)
- [Flutter SVG](https://pub.dev/packages/flutter_svg)
- [Lottie](https://pub.dev/packages/lottie)
- [Intl](https://pub.dev/packages/intl)
- [Auto Size Text](https://pub.dev/packages/auto_size_text)
- [Carousel Slider](https://pub.dev/packages/carousel_slider)
- [Flutter Staggered Grid View](https://pub.dev/packages/flutter_staggered_grid_view)
- [Moor Flutter](https://pub.dev/packages/moor_flutter)
- [Modal Bottom Sheet](https://pub.dev/packages/modal_bottom_sheet)
- [Get Storage](https://pub.dev/packages/get_storage)
- [Flutter Color](https://pub.dev/packages/flutter_color)
- [Percent Indicator](https://pub.dev/packages/percent_indicator)
- [Scrollable Positioned List](https://pub.dev/packages/scrollable_positioned_list)
- [Auto Animated](https://pub.dev/packages/auto_animated)
- [Day Night Time Picker](https://pub.dev/packages/day_night_time_picker)
- [Calendar_Timeline (custom)](https://pub.dev/packages/calendar_timeline)

<details>
  <summary><b>TODO!</b></summary>
  <br>
  
  ## Screen
  - [x] Splash Page
  - [x] OnBoard Page
  - [x] Dashboard Page
  - [ ] Bag Page
  - [x] Calendar Page
  - [ ] Profile Page
  - [x] Add Task BottomSheet
  - [x] Detail Task
  - [x] Detail Category
  - [x] Search Page

  ## Util Tasks
  - [x] Focus Node unfocused
  - [x] dropdown null value
  - [x] completed attribute
  - [x] task with category list
  - [x] category with total tasks
  - [x] done tasks
  - [x] fix padding in bottom nav bar item
  - [x] cleaning up dao
  - [x] error border
  - [x] update & delete tasks
  - [x] create snackBar
  - [x] date & time picker cupertino
  - [x] change time picker [with this lib](https://pub.dev/packages/day_night_time_picker)
  - [ ] add category task
  - [ ] search in category
  - [ ] edit category
  - [ ] change description of onboard
  - [x] total task of on going or complete

  ## Future Feature
  - [ ] save to excel
  - [ ] notification
  - [ ] statistics
  - [ ] event organizer
  - [x] calendar
  - [ ] multi-language
  - [ ] setting
  - [ ] attachment
  - [x] search tasks
  - [ ] [showcase](https://pub.dev/packages/showcaseview)
  - [ ] Backup to Cloud
  - [ ] Sign in & Sign up

  ## Feedback from user
  - [x] scrollable list at the end of item will scroll overflow
  - [x] number in time picker is missing, use all number instead. (change style of time picker) 
  - [ ] scroll calendar animation no smooth
  - [x] description make optional
  - [x] initial category task (work, health)
  - [x] in the calendar, if the day is sunday, set different color (pink)
  - [x] list animation in search
  - [ ] category task remove see all
  - [x] update task -> mark as done, check icon save edit
  - [x] delete task add dialog before really deleted
  
</details>
 -->
