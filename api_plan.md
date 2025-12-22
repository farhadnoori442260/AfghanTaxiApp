# API Plan - Taxi App

این فایل برنامه کلی API را مشخص می‌کند.
پیاده‌سازی واقعی بعداً انجام می‌شود.

---

## Driver APIs
- POST /driver/register
- POST /driver/login
- GET /driver/profile
- GET /driver/trips

---

## Passenger APIs
- POST /passenger/register
- POST /passenger/login
- POST /trip/request
- GET /trip/price

---

## Trip APIs
- POST /trip/accept
- POST /trip/complete
- GET /trip/history

---

## Admin APIs
- POST /admin/login
- GET /admin/drivers
- POST /admin/driver/approve
- POST /admin/driver/block
- GET /admin/trips
- GET /admin/reports
- POST /admin/settings