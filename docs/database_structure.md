# Database Structure - Taxi App

این فایل ساختار دیتابیس اپلیکیشن تاکسی را توضیح می‌دهد.
این ساختار پایه‌ی اپ مسافر، اپ راننده و پنل مدیریت است.

---

## Table: drivers
اطلاعات راننده‌ها

- id (int, primary key)
- name (string)
- phone (string)
- car_model (string)
- car_number (string)
- status (pending | approved | blocked)
- wallet_balance (double)
- created_at (datetime)

---

## Table: passengers
اطلاعات مسافرها

- id (int, primary key)
- name (string)
- phone (string)
- created_at (datetime)

---

## Table: trips
اطلاعات تمام سفرها (هسته سیستم)

- id (int, primary key)
- driver_id (int)
- passenger_id (int)
- start_lat (double)
- start_lng (double)
- end_lat (double)
- end_lng (double)
- distance_km (double)
- price (double)
- commission_amount (double)
- driver_earn (double)
- status (requested | accepted | completed | canceled)
- created_at (datetime)

---

## Table: settings
تنظیمات مدیریتی سیستم

- id (int)
- base_price (double)
- price_per_km (double)
- commission_percent (int)

---

## Table: admin_users
کاربران پنل مدیریت

- id (int, primary key)
- username (string)
- password (string, hashed)
- created_at (datetime)
