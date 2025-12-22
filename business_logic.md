# Business Logic - Taxi App

این فایل منطق اصلی کار اپلیکیشن تاکسی را توضیح می‌دهد.

---

## Travel Flow (جریان سفر)

request_trip
→ driver_accept
→ trip_start
→ trip_end
→ calculate_fare
→ calculate_commission
→ save_trip
→ show_in_admin_panel

---

## Fare Calculation (محاسبه کرایه)

فرمول کرایه:

price = base_price + (distance_km × price_per_km)

مثال:
- base_price = 50
- price_per_km = 20
- distance = 8 km

price = 50 + (8 × 20) = 210

---

## Commission Calculation (محاسبه کمیسیون)

commission = price × commission_percent / 100

driver_earn = price - commission

مثال:
- price = 210
- commission_percent = 10%

commission = 21  
driver_earn = 189

---

## Driver Status Rules

- pending → راننده ثبت‌نام کرده، تأیید نشده
- approved → راننده فعال و مجاز به سفر
- blocked → راننده مسدود شده

---

## Trip Status Rules

- requested → درخواست ارسال شده
- accepted → راننده قبول کرده
- completed → سفر انجام شده
- canceled → سفر لغو شده

---

## Permissions

- Driver:
  - قبول / رد سفر
  - دیدن درآمد خود

- Passenger:
  - درخواست سفر
  - دیدن قیمت

- Admin:
  - تأیید یا بلاک راننده
  - دیدن همه سفرها
  - تغییر قیمت‌ها و کمیسیون
  - دیدن گزارش مالی