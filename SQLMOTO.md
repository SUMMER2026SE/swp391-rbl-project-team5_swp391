-- =============================================
-- SmartRide WEBSITE - PostgreSQL Schema
-- Dành cho Supabase
-- =============================================

-- Xóa bảng cũ nếu có (theo thứ tự ngược FK)
DROP TABLE IF EXISTS "Favorite" CASCADE;
DROP TABLE IF EXISTS "Notification" CASCADE;
DROP TABLE IF EXISTS "GPSAlert" CASCADE;
DROP TABLE IF EXISTS "MotorcycleGPS" CASCADE;
DROP TABLE IF EXISTS "LocationMotorcycleRecommendation" CASCADE;
DROP TABLE IF EXISTS "Extension" CASCADE;
DROP TABLE IF EXISTS "Cancellation" CASCADE;
DROP TABLE IF EXISTS "DemandPriceRange" CASCADE;
DROP TABLE IF EXISTS "Demand_Detail" CASCADE;
DROP TABLE IF EXISTS "Demand" CASCADE;
DROP TABLE IF EXISTS "TouristLocation" CASCADE;
DROP TABLE IF EXISTS "AccessoryDetail" CASCADE;
DROP TABLE IF EXISTS "Event" CASCADE;
DROP TABLE IF EXISTS "Payment" CASCADE;
DROP TABLE IF EXISTS "Booking Detail" CASCADE;
DROP TABLE IF EXISTS "BookingVerification" CASCADE;
DROP TABLE IF EXISTS "Motorcycle Detail" CASCADE;
DROP TABLE IF EXISTS "Motorcycle" CASCADE;
DROP TABLE IF EXISTS "Booking" CASCADE;
DROP TABLE IF EXISTS "Voucher" CASCADE;
DROP TABLE IF EXISTS "Feedback" CASCADE;
DROP TABLE IF EXISTS "Customer" CASCADE;
DROP TABLE IF EXISTS "Staff" CASCADE;
DROP TABLE IF EXISTS "Contact" CASCADE;
DROP TABLE IF EXISTS "PasswordResetToken" CASCADE;
DROP TABLE IF EXISTS "Account" CASCADE;
DROP TABLE IF EXISTS "PriceList" CASCADE;
DROP TABLE IF EXISTS "Policies" CASCADE;
DROP TABLE IF EXISTS "CategoryPolicy" CASCADE;
DROP TABLE IF EXISTS "FAQ" CASCADE;
DROP TABLE IF EXISTS "Category" CASCADE;
DROP TABLE IF EXISTS "Brand" CASCADE;
DROP TABLE IF EXISTS "Role" CASCADE;
DROP TABLE IF EXISTS "Accessory" CASCADE;

-- =============================================
-- TẠO CÁC BẢNG
-- =============================================

CREATE TABLE "Accessory" (
    "AccessoryID"          SERIAL PRIMARY KEY,
    "AccessoryName"        VARCHAR(40)  NOT NULL,
    "AccessoryImage"       TEXT         NOT NULL,
    "AccessoryImageIcon"   TEXT         NOT NULL,
    "AccessoryDescription" TEXT         NULL,
    "Price"                DECIMAL(10,3) NULL
);

CREATE TABLE "Role" (
    "RoleID"   SERIAL PRIMARY KEY,
    "RoleName" VARCHAR(50) NOT NULL
);

CREATE TABLE "Account" (
    "AccountID"   SERIAL PRIMARY KEY,
    "FirstName"   VARCHAR(50)  NULL,
    "LastName"    VARCHAR(50)  NULL,
    "Gender"      VARCHAR(30)  NULL,
    "DayOfBirth"  DATE         NULL,
    "Address"     VARCHAR(255) NULL,
    "PhoneNumber" VARCHAR(13)  NULL UNIQUE,
    "Image"       TEXT         NULL,
    "Email"       VARCHAR(255) NOT NULL UNIQUE,
    "Username"    VARCHAR(255) NOT NULL UNIQUE,
    "Password"    VARCHAR(50)  NOT NULL,
    "RoleID"      INT          NULL REFERENCES "Role"("RoleID")
);
ALTER TABLE "Account" ALTER COLUMN "Password" TYPE VARCHAR(255);

CREATE TABLE "Customer" (
    "CustomerID"        SERIAL PRIMARY KEY,
    "IdentityCard"      VARCHAR(12)  NOT NULL UNIQUE,
    "IdentityCardImage" TEXT         NOT NULL,
    "IssuedOnDate"      DATE         NOT NULL,
    "ExpDate"           DATE         NOT NULL,
    "TypeCard"          VARCHAR(50)  NOT NULL CHECK ("TypeCard" IN ('CMND/CCCD', 'Bằng lái xe')),
    "AccountID"         INT          NOT NULL UNIQUE REFERENCES "Account"("AccountID")
);

CREATE TABLE "Staff" (
    "StaffID"   CHAR(10) PRIMARY KEY,
    "ManagerID" CHAR(10) NOT NULL,
    "AccountID" INT      NOT NULL UNIQUE REFERENCES "Account"("AccountID"),
    FOREIGN KEY ("ManagerID") REFERENCES "Staff"("StaffID")
);

CREATE TABLE "Category" (
    "CategoryID"   SERIAL PRIMARY KEY,
    "CategoryName" VARCHAR(255) NOT NULL
);

CREATE TABLE "Brand" (
    "BrandID"   SERIAL PRIMARY KEY,
    "BrandName" VARCHAR(10) NOT NULL
);

CREATE TABLE "PriceList" (
    "PriceListID"        SERIAL PRIMARY KEY,
    "DailyPriceForDay"   DECIMAL(10,3) NOT NULL,
    "DailyPriceForWeek"  DECIMAL(10,3) NOT NULL,
    "DailyPriceForMonth" DECIMAL(10,3) NOT NULL
);


CREATE TABLE "Motorcycle" (
    "MotorcycleID"  CHAR(6)      PRIMARY KEY,
    "Model"         VARCHAR(30)  NOT NULL,
    "Image"         TEXT         NOT NULL,
    "Displacement"  VARCHAR(10)  NULL,
    "Description"   TEXT         NOT NULL,
    "MinAge"        INT          NOT NULL,
    "BrandID"       INT          NOT NULL REFERENCES "Brand"("BrandID"),
    "CategoryID"    INT          NULL     REFERENCES "Category"("CategoryID"),
    "PriceListID"   INT          NULL     REFERENCES "PriceList"("PriceListID")
);

CREATE TABLE "Motorcycle Detail" (
    "MotorcycleDetailID" SERIAL PRIMARY KEY,
    "MotorcycleID"       CHAR(6)  NOT NULL REFERENCES "Motorcycle"("MotorcycleID"),
    "LicensePlate"       CHAR(18) NOT NULL UNIQUE,
    "CurrentStatus"      VARCHAR(35) NOT NULL DEFAULT 'Có sẵn'
        CHECK ("CurrentStatus" IN ('Có sẵn', 'Không có sẵn', 'Đang thuê', 'Bảo dưỡng')),
    "UpdatedByStaffID"   CHAR(10) NULL REFERENCES "Staff"("StaffID"),
    "StatusUpdatedAt"    TIMESTAMP NULL,
    "StatusNote"         TEXT NULL
);

CREATE TABLE "Voucher" (
    "VoucherID"      SERIAL PRIMARY KEY,
    "Code"           VARCHAR(20) NOT NULL UNIQUE,
    "DiscountAmount" DECIMAL(10,3) NOT NULL CHECK ("DiscountAmount" >= 0),
    "Description"    TEXT NOT NULL,
    "StartDate" TIMESTAMP NULL,
    "EndDate" TIMESTAMP NULL,
    "CreatedTime"    TIMESTAMP NOT NULL DEFAULT NOW(),
    "Status"         VARCHAR(20) NOT NULL DEFAULT 'Đang hoạt động'
        CHECK ("Status" IN ('Đang hoạt động', 'Ngừng hoạt động')),
    "UsageLimit"     INT NULL CHECK ("UsageLimit" IS NULL OR "UsageLimit" > 0),
    "UsedCount"      INT NOT NULL DEFAULT 0 CHECK ("UsedCount" >= 0),
    "MaxUsagePerCustomer" INT NOT NULL DEFAULT 1
        CHECK ("MaxUsagePerCustomer" > 0)
);

CREATE TABLE "Booking" (
    "BookingID"        CHAR(10)     PRIMARY KEY,
    "BookingDate"      TIMESTAMP    NOT NULL DEFAULT NOW(),
    "StartDate"        TIMESTAMP    NOT NULL,
    "EndDate"          TIMESTAMP    NOT NULL,
    "StatusBooking"    VARCHAR(255) NOT NULL CHECK ("StatusBooking" IN ('Chờ xác nhận', 'Đã xác nhận', 'Đã hủy')),
    "DeliveryLocation" VARCHAR(255) NOT NULL,
    "ReturnedLocation" VARCHAR(255) NOT NULL,
    "DeliveryStatus"   VARCHAR(30)  NULL CHECK ("DeliveryStatus" IN ('Chưa giao', 'Đã giao', 'Đã trả')),
    "VoucherID"        INT          NULL REFERENCES "Voucher"("VoucherID"),
    "CustomerID"       INT          NOT NULL REFERENCES "Customer"("CustomerID")
);

CREATE TABLE "Booking Detail" (
    "BookingDetailID"    SERIAL PRIMARY KEY,
    "MotorcycleDetailID" INT NOT NULL REFERENCES "Motorcycle Detail"("MotorcycleDetailID"),
    "BookingID"          CHAR(10) NOT NULL REFERENCES "Booking"("BookingID"),
    "TotalPrice"         DECIMAL(10,3) NULL,
    CONSTRAINT "UQ_BookingDetail_Booking_Motorcycle" UNIQUE ("BookingID", "MotorcycleDetailID")
);

CREATE TABLE "BookingVerification" (
    "BookingVerificationID" SERIAL    PRIMARY KEY,
    "BookingID"             CHAR(10)  NOT NULL UNIQUE REFERENCES "Booking"("BookingID"),
    "StaffID"               CHAR(10)  NULL REFERENCES "Staff"("StaffID"),
    "VerificationDate"      TIMESTAMP NULL
);

CREATE TABLE "Feedback" (
    "FeedbackID"   SERIAL    PRIMARY KEY,
    "Content"      TEXT      NOT NULL,
    "productRate"  INT       NOT NULL DEFAULT 0 CHECK ("productRate" IN (1,2,3,4,5)),
    "serviceRate"  INT       NOT NULL DEFAULT 0 CHECK ("serviceRate" IN (1,2,3,4,5)),
    "deliveryRate" INT       NOT NULL DEFAULT 0 CHECK ("deliveryRate" IN (1,2,3,4,5)),
    "feedbackTime" TIMESTAMP NULL,
    "CustomerID"   INT       NOT NULL REFERENCES "Customer"("CustomerID"),
    "BookingID"    CHAR(10)  NULL UNIQUE REFERENCES "Booking"("BookingID")
);

CREATE TABLE "Payment" (
    "PaymentID"     SERIAL       PRIMARY KEY,
    "BookingID"     CHAR(10)     NOT NULL UNIQUE REFERENCES "Booking"("BookingID"),
    "PaymentMethod" VARCHAR(50)  NOT NULL,
    "PaymentDate"   TIMESTAMP    NOT NULL DEFAULT NOW(),
    "PaymentAmount" DECIMAL(10,3) NULL CHECK ("PaymentAmount" >= 0),
    "PaymentStatus" VARCHAR(50)  NULL
);

CREATE TABLE "Cancellation" (
    "CancellationID"   SERIAL    PRIMARY KEY,
    "CancellationDate" TIMESTAMP NOT NULL DEFAULT NOW(),
    "Note"             TEXT      NOT NULL,
    "BookingID"        CHAR(10)  NOT NULL UNIQUE REFERENCES "Booking"("BookingID"),
    "StaffID"          CHAR(10)  NULL REFERENCES "Staff"("StaffID")
);

CREATE TABLE "Extension" (
    "ExtensionID"    SERIAL       PRIMARY KEY,
    "ExtensionDate"  TIMESTAMP    NOT NULL DEFAULT NOW(),
    "PreviousEndDate" TIMESTAMP   NOT NULL,
    "NewEndDate"     TIMESTAMP    NOT NULL,
    "ExtenstionFee"  DECIMAL(10,3) NULL CHECK ("ExtenstionFee" > 0),
    "BookingID"      CHAR(10)     NOT NULL UNIQUE REFERENCES "Booking"("BookingID"),
    "StaffID"        CHAR(10)     NULL REFERENCES "Staff"("StaffID")
);

CREATE TABLE "AccessoryDetail" (
    "BookingID"   CHAR(10) NOT NULL REFERENCES "Booking"("BookingID"),
    "AccessoryID" INT NOT NULL REFERENCES "Accessory"("AccessoryID"),
    "Quantity"    INT NOT NULL DEFAULT 0 CHECK ("Quantity" >= 0),
    "TotalPrice"  DECIMAL(10,3) NOT NULL,
    CONSTRAINT "PK_AccessoryDetail" PRIMARY KEY ("BookingID", "AccessoryID")
);

CREATE TABLE "Contact" (
    "ContactID"   SERIAL      PRIMARY KEY,
    "Name"        VARCHAR(50) NOT NULL,
    "PhoneNumber" VARCHAR(10) NOT NULL,
    "Email"       VARCHAR(255) NOT NULL,
    "Title"       VARCHAR(50) NOT NULL,
    "Message"     TEXT        NOT NULL,
    "AccountID"   INT         NULL REFERENCES "Account"("AccountID")
);

CREATE TABLE "FAQ" (
    "QuestionID" SERIAL PRIMARY KEY,
    "Question"   TEXT   NOT NULL,
    "Answer"     TEXT   NULL
);

CREATE TABLE "CategoryPolicy" (
    "CategoryPolicyId"    SERIAL PRIMARY KEY,
    "CategoryPolicyTitle" TEXT   NOT NULL
);

CREATE TABLE "Policies" (
    "Id"               SERIAL PRIMARY KEY,
    "PoliciesTitle"    TEXT NOT NULL,
    "Content"          TEXT NOT NULL,
    "CategoryPolicies" INT  NULL REFERENCES "CategoryPolicy"("CategoryPolicyId")
);

CREATE TABLE "Event" (
    "EventID"    SERIAL       PRIMARY KEY,
    "EventTitle" VARCHAR(100) NOT NULL,
    "CreatedDate" TIMESTAMP   NOT NULL DEFAULT NOW(),
    "StartDate"  TIMESTAMP    NOT NULL,
    "EndDate"    TIMESTAMP    NOT NULL,
    "Content"    TEXT         NOT NULL,
    "EventImage" TEXT         NOT NULL,
    "Discount"   DECIMAL(10,3) NULL DEFAULT 0 CHECK ("Discount" >= 0 AND "Discount" <= 1),
    "StaffID"    CHAR(10)     NOT NULL REFERENCES "Staff"("StaffID")
);

CREATE TABLE "TouristLocation" (
    "LocationID"   SERIAL      PRIMARY KEY,
    "LocationName" VARCHAR(50) NOT NULL,
    "LocationImage" TEXT       NOT NULL,
    "Description"  TEXT        NOT NULL,
    "UrlArticle"   TEXT        NOT NULL,
    "StaffID"      CHAR(10)    NOT NULL REFERENCES "Staff"("StaffID")
);

CREATE TABLE "Demand" (
    "DemandId" SERIAL       PRIMARY KEY,
    "Demand"   VARCHAR(100) NOT NULL
);

CREATE TABLE "Demand_Detail" (
    "DemandDetailId" SERIAL PRIMARY KEY,
    "MotorcycleID"   CHAR(6) NOT NULL REFERENCES "Motorcycle"("MotorcycleID"),
    "DemandId"       INT NOT NULL REFERENCES "Demand"("DemandId"),
    CONSTRAINT "UQ_DemandDetail_Motorcycle_Demand" UNIQUE ("MotorcycleID", "DemandId")
);

CREATE TABLE "DemandPriceRange" (
    "PriceRangeId" SERIAL        PRIMARY KEY,
    "MinPrice"     DECIMAL(10,3) NULL,
    "MaxPrice"     DECIMAL(10,3) NULL
);

CREATE TABLE "PasswordResetToken" (
    "Id"         SERIAL       PRIMARY KEY,
    "Email"      VARCHAR(255) NULL,
    "Token"      VARCHAR(255) NOT NULL,
    "Expiration" TIMESTAMP    NOT NULL,
    "AccountID"  INT          NULL REFERENCES "Account"("AccountID")
);


CREATE TABLE "LocationMotorcycleRecommendation" (
    "RecommendationID" SERIAL PRIMARY KEY,
    "LocationID" INT NOT NULL REFERENCES "TouristLocation"("LocationID"),
    "MotorcycleID" CHAR(6) NOT NULL REFERENCES "Motorcycle"("MotorcycleID"),
    "Reason" TEXT NULL,
    "Priority" INT NULL DEFAULT 1,
    CONSTRAINT "UQ_LocationMotorcycleRecommendation" UNIQUE ("LocationID", "MotorcycleID")
);

CREATE TABLE "MotorcycleGPS" (
    "GPSID" SERIAL PRIMARY KEY,
    "MotorcycleDetailID" INT NOT NULL UNIQUE REFERENCES "Motorcycle Detail"("MotorcycleDetailID"),
    "Latitude" DECIMAL(10,7) NOT NULL,
    "Longitude" DECIMAL(10,7) NOT NULL,
    "UpdatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "GPSAlert" (
    "AlertID" SERIAL PRIMARY KEY,
    "MotorcycleDetailID" INT NOT NULL REFERENCES "Motorcycle Detail"("MotorcycleDetailID"),
    "AlertType" VARCHAR(50) NOT NULL
        CHECK ("AlertType" IN ('Quá hạn trả xe', 'Ra khỏi khu vực', 'Mất tín hiệu')),
    "Message" TEXT NOT NULL,
    "CreatedAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "Status" VARCHAR(30) NOT NULL DEFAULT 'Chưa xử lý'
        CHECK ("Status" IN ('Chưa xử lý', 'Đã xử lý'))
);
-- 1. Bảng Favorite (Lưu trữ danh sách xe yêu thích của người dùng)
CREATE TABLE IF NOT EXISTS "Favorite" (
    "favorite_id" SERIAL PRIMARY KEY,
    "account_id" INT NOT NULL,
    "motorcycle_id" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "fk_favorite_account" FOREIGN KEY ("account_id") REFERENCES "Account" ("AccountId") ON DELETE CASCADE,
    CONSTRAINT "fk_favorite_motorcycle" FOREIGN KEY ("motorcycle_id") REFERENCES "Motorcycle" ("MotorcycleID") ON DELETE CASCADE
);
-- Tạo Index để tăng tốc độ truy vấn danh sách yêu thích của người dùng
CREATE INDEX IF NOT EXISTS "idx_favorite_account" ON "Favorite" ("account_id");
-- 2. Bảng Notification (Lưu trữ các thông báo hệ thống và sự kiện)
CREATE TABLE IF NOT EXISTS "Notification" (
    "notification_id" SERIAL PRIMARY KEY,
    "account_id" INT NULL, -- Nếu NULL thì đây là thông báo gửi cho tất cả mọi người (Broadcast)
    "title" VARCHAR(255) NOT NULL,
    "message" TEXT NOT NULL,
    "link" VARCHAR(255), -- Link điều hướng khi bấm vào thông báo
    "is_read" BOOLEAN DEFAULT FALSE,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "fk_notification_account" FOREIGN KEY ("account_id") REFERENCES "Account" ("AccountId") ON DELETE CASCADE
);
-- Tạo Index để tăng tốc độ load thông báo cho từng cá nhân
CREATE INDEX IF NOT EXISTS "idx_notification_account" ON "Notification" ("account_id");

-- =============================================
-- SmartRide WEBSITE - PostgreSQL Sample Data
-- Dành cho Supabase
-- =============================================

-- Xóa data cũ theo thứ tự ngược FK
TRUNCATE TABLE "GPSAlert", "MotorcycleGPS", "LocationMotorcycleRecommendation",
    "Extension", "Cancellation", "DemandPriceRange", "Demand_Detail", "Demand",
    "TouristLocation", "AccessoryDetail", "Event", "Payment", "Booking Detail",
    "BookingVerification", "Motorcycle Detail", "Motorcycle",
    "Booking", "Voucher", "Feedback", "Customer", "Staff", "Contact",
    "PasswordResetToken", "Account", "PriceList",
    "Policies", "CategoryPolicy", "FAQ", "Category",
    "Brand", "Role", "Accessory" RESTART IDENTITY CASCADE;

-- Accessory
INSERT INTO "Accessory" ("AccessoryName", "AccessoryImage", "AccessoryImageIcon", "AccessoryDescription", "Price") VALUES
('Mũ bảo hiểm 3/4',    'imageAccess1.jpg', 'imageAccIcon1.jpg', 'Mũ bảo hiểm chất lượng cao, đảm bảo an toàn và thoải mái.', 20000),
('Găng tay',            'imageAccess2.jpg', 'imageAccIcon2.jpg', 'Găng tay bảo vệ chống nắng và gió.', 0),
('Giá đỡ điện thoại',   'imageAccess3.jpg', 'imageAccIcon3.jpg', 'Giá đỡ điện thoại chắc chắn, dễ lắp đặt.', 0),
('Mũ bảo hiểm full face','imageAccess4.jpg', 'imageAccIcon4.jpg', 'Mũ bảo hiểm chất lượng cao, đảm bảo an toàn.', 30000),
('Áo mưa rời',          'imageAccess5.jpg', 'imageAccIcon5.jpg', 'Áo mưa tiện lợi, dễ mang theo.', 10000),
('Nylon bọc giày',      'imageAccess6.jpg', 'imageAccIcon6.jpg', 'Bảo vệ giày khi trời mưa.', 0),
('Dụng cụ vá xe',       'imageAccess7.jpg', 'imageAccIcon7.jpg', 'Bộ dụng cụ vá xe tiện lợi.', 0);

-- Category, Brand, Role
INSERT INTO "Category" ("CategoryName") VALUES ('Xe tay ga'),('Xe số'),('Xe máy điện'),('Xe máy 50cc'),('Xe côn'),('Xe thể thao');
INSERT INTO "Brand" ("BrandName") VALUES ('Yamaha'),('Honda'),('Suzuki'),('Sym'),('Piaggio'),('VinFast');
INSERT INTO "Role" ("RoleName") VALUES
('Khách hàng'),
('Nhân viên'),
('Nhân viên quản lý'),
('Khách hàng (vô hiệu)'),
('Nhân viên (vô hiệu)');

-- Account (3 tài khoản chính)
INSERT INTO "Account" ("FirstName","LastName","Gender","DayOfBirth","Address","PhoneNumber","Image","Email","Username","Password","RoleID") VALUES
('Nguyễn Văn','Khách',    'Nam', '2000-01-01', 'Đà Nẵng', '0900000001', NULL, 'khach@gmail.com',    'khach',    '123456', 1),
('Trần Thị',  'Nhân Viên','Nữ',  '1995-01-01', 'Đà Nẵng', '0900000002', NULL, 'nhanvien@gmail.com', 'nhanvien', '123456', 2),
('Lê Văn',    'Admin',    'Nam', '1990-01-01', 'Đà Nẵng', '0900000003', NULL, 'admin@gmail.com',    'admin',    '123456', 3);

-- FAQ
INSERT INTO "FAQ" ("Question","Answer") VALUES
('Chính sách đổi trả cho các sản phẩm mua trực tuyến là gì?', 'Chính sách đổi trả của chúng tôi cho phép bạn đổi trả bất kỳ sản phẩm nào mua trực tuyến trong vòng 30 ngày kể từ khi nhận hàng.'),
('Làm thế nào để liên hệ với dịch vụ khách hàng?', 'Bạn có thể gọi đến số 123-456-7890 từ thứ Hai đến thứ Sáu, từ 9 giờ sáng đến 6 giờ chiều.'),
('Vị trí và giờ mở cửa của bạn là gì?', 'Chúng tôi mở cửa từ thứ Hai đến thứ Bảy từ 9 giờ sáng đến 9 giờ tối.'),
('Giá thuê xe máy tại SmartRide là bao nhiêu?', 'Giá dao động từ 150.000đ – 350.000đ/ngày tùy loại xe. Khách hàng thuê dài ngày sẽ có chính sách giá ưu đãi riêng.'),
('Cần giấy tờ gì để thuê xe?', 'Bắt buộc: CMND/CCCD/Hộ chiếu còn hiệu lực và Giấy phép lái xe (A1/A2) hợp lệ. Với khách du lịch nước ngoài, cần có Hộ chiếu và Bằng lái xe quốc tế.'),
('SmartRide có giao nhận xe tận nơi không?', 'Có! Chúng tôi hỗ trợ giao và nhận xe tận nơi tại các điểm trong nội thành Đà Nẵng (Sân bay, ga tàu, khách sạn) với mức phụ phí nhỏ từ 30.000đ – 80.000đ.'),
('Có thể gia hạn thời gian thuê xe không?', 'Hoàn toàn được. Vui lòng liên hệ với bộ phận CSKH ít nhất 2 giờ trước khi kết thúc hợp đồng để chúng tôi gia hạn và tính thêm phí theo ngày phát sinh.'),
('Thuê xe dài ngày hoặc theo tháng có được giảm giá không?', 'Chắc chắn rồi! SmartRide có chính sách giảm ngay 20–30% so với giá ngày cho các hợp đồng thuê xe theo tháng. Vui lòng liên hệ trực tiếp để nhận báo giá chi tiết.'),
('Xe bị hỏng giữa đường thì có được hỗ trợ không?', 'SmartRide hỗ trợ cứu hộ 24/7. Trong trường hợp xe gặp sự cố kỹ thuật ngoài ý muốn, hãy gọi ngay hotline, nhân viên sẽ đến tận nơi xử lý hoặc đổi xe khác cho bạn.'),
('Giá thuê đã bao gồm xăng chưa?', 'Giá thuê chưa bao gồm chi phí xăng xe. Khi nhận xe sẽ có sẵn 1 lít xăng, quý khách vui lòng tự đổ thêm xăng trong quá trình di chuyển.'),
('Có giới hạn số km di chuyển mỗi ngày không?', 'Không. Chúng tôi không giới hạn số km khi quý khách di chuyển trong phạm vi nội thành Đà Nẵng và các địa điểm du lịch lân cận.'),
('Tôi có cần đặt cọc tiền mặt khi thuê xe không?', 'Tuỳ vào loại xe và giấy tờ bạn cung cấp. Thông thường, nếu bạn để lại giấy tờ tuỳ thân gốc (CCCD/Passport), bạn sẽ không cần đặt cọc tiền mặt đối với các dòng xe phổ thông.'),
('Phí thuê xe có bao gồm mũ bảo hiểm không?', 'Có, mỗi xe thuê tại SmartRide đều được trang bị miễn phí 2 mũ bảo hiểm đạt chuẩn an toàn, 2 áo mưa dự phòng và dây chằng đồ.');
-- CategoryPolicy & Policies
INSERT INTO "CategoryPolicy" ("CategoryPolicyTitle") VALUES
('Chính sách và quy định'),('Nguyên tắc chung'),('Chính sách bảo mật'),('Giải quyết khiếu nại');

INSERT INTO "Policies" ("PoliciesTitle","Content","CategoryPolicies") VALUES
('Chính sách đổi trả',    'Nội dung chính sách đổi trả...', 1),
('Chính sách bảo mật',    'Nội dung chính sách bảo mật...', 3),
('Điều khoản và điều kiện','Nội dung điều khoản và điều kiện...', 2),
('Chính sách vận chuyển', 'Nội dung chính sách vận chuyển...', 1),
('Chính sách hủy',        'Nội dung chính sách hủy...', 1),
('Chính sách hoàn tiền',  'Nội dung chính sách hoàn tiền...', 1),
('Chính sách cookie',     'Nội dung chính sách cookie...', 3),
('Giải quyết khiếu nại',  'Nội dung giải quyết khiếu nại...', 4);

-- PriceList
INSERT INTO "PriceList" ("DailyPriceForDay","DailyPriceForWeek","DailyPriceForMonth") VALUES
(110000,100000,90000),(115000,105000,95000),(120000,110000,100000),(135000,125000,115000),(140000,130000,120000),
(150000,140000,130000),(155000,145000,135000),(190000,180000,170000),(200000,190000,180000),(215000,200000,190000),
(230000,220000,200000),(250000,240000,230000),(300000,290000,280000),(320000,310000,300000);

-- Insert Customer
INSERT INTO "Customer" ("IdentityCard","IdentityCardImage","IssuedOnDate","ExpDate","TypeCard","AccountID") VALUES
('200000000001','imageIdC1.jpg','2015-01-01','2025-01-01','CMND/CCCD',1);

-- Staff (phải insert trước Voucher/Booking vì FK)
INSERT INTO "Staff" ("StaffID","ManagerID","AccountID") VALUES ('STAFF00001','STAFF00001',2);
INSERT INTO "Staff" ("StaffID","ManagerID","AccountID") VALUES ('MANAGER001','STAFF00001',3);

-- Voucher (public voucher: 1 voucher có thể dùng cho nhiều booking)
INSERT INTO "Voucher" ("Code","DiscountAmount","Description","CreatedTime","Status","UsageLimit","UsedCount","MaxUsagePerCustomer") VALUES
('VOU10K',10000,'Giảm giá 10,000 VNĐ cho mỗi đơn hàng','2026-05-11','Đang hoạt động',100,1,1),
('SUMMER20',20000,'Giảm giá mùa hè 20,000 VNĐ','2026-06-01','Đang hoạt động',200,0,1);

-- Booking
INSERT INTO "Booking" ("BookingID", "BookingDate", "StartDate", "EndDate", "StatusBooking", "DeliveryLocation", "ReturnedLocation", "DeliveryStatus", "VoucherID", "CustomerID") VALUES
('BKTEST0001', '2026-05-02', '2026-05-03', '2026-05-05', 'Đã xác nhận', 'Đà Nẵng', 'Đà Nẵng', 'Đã trả', 1, 1),
('BKTEST0002', '2026-05-05', '2026-05-06', '2026-05-08', 'Đã xác nhận', 'Đà Nẵng', 'Đà Nẵng', 'Đã trả', NULL, 1),
('BKTEST0003', '2026-05-08', '2026-05-09', '2026-05-11', 'Đã xác nhận', 'Đà Nẵng', 'Đà Nẵng', 'Đã trả', 2, 1),
('BKTEST0004', '2026-05-12', '2026-05-12', '2026-05-15', 'Đã xác nhận', 'Đà Nẵng', 'Đà Nẵng', 'Đã trả', NULL, 1),
('BKTEST0005', '2026-05-15', '2026-05-16', '2026-05-18', 'Đã xác nhận', 'Đà Nẵng', 'Đà Nẵng', 'Đã trả', 1, 1),
('BKTEST0006', '2026-05-18', '2026-05-19', '2026-05-20', 'Đã xác nhận', 'Đà Nẵng', 'Đà Nẵng', 'Đã trả', NULL, 1),
('BKTEST0007', '2026-05-22', '2026-05-22', '2026-05-25', 'Đã xác nhận', 'Đà Nẵng', 'Đà Nẵng', 'Đã trả', NULL, 1),
('BKTEST0008', '2026-05-26', '2026-05-27', '2026-05-28', 'Đã xác nhận', 'Đà Nẵng', 'Đà Nẵng', 'Đã trả', 2, 1),
('BKTEST0009', '2026-05-29', '2026-05-30', '2026-06-01', 'Đã xác nhận', 'Đà Nẵng', 'Đà Nẵng', 'Đã trả', NULL, 1),
('BKTEST0010', '2026-06-01', '2026-06-02', '2026-06-04', 'Đã xác nhận', 'Đà Nẵng', 'Đà Nẵng', 'Đã giao', 1, 1);

-- Feedback (sau Booking)
INSERT INTO "Feedback" ("Content","productRate","serviceRate","deliveryRate","CustomerID","BookingID") VALUES
('Dịch vụ tốt, xe đẹp, sẽ quay lại lần sau!',5,5,5,1,'BKTEST0001');
-- BookingVerification
INSERT INTO "BookingVerification" ("BookingID","StaffID","VerificationDate") VALUES
('BKTEST0001','STAFF00001','2024-05-01 10:00:00');

-- Motorcycle
-- Motorcycle
INSERT INTO "Motorcycle" ("MotorcycleID","Model","Image","Displacement","Description","MinAge","BrandID","CategoryID","PriceListID") VALUES
('M00001','Yamaha NVX',      'imageM1.jpg', '155cc', 'Siêu xe tay ga thể thao mang đậm chất X-MAX, động cơ Blue Core 155cc VVA vận hành mạnh mẽ, cốp siêu rộng 25L. Lựa chọn số 1 cho phái mạnh yêu sự tiện nghi.', 18,1,1,9),
('M00002','Yamaha Exciter',  'imageM2.jpg', '150cc', 'Ông vua đường phố thực thụ với thiết kế khí động học cuốn hút, động cơ 150cc bứt tốc mạnh mẽ và phanh mượt mà. Đem lại sự tự tin trên mọi cung đường.', 18,1,5,8),
('M00003','Yamaha Sirius',   'imageM3.jpg', '110cc', 'Mẫu xe số quốc dân siêu bền bỉ và tiết kiệm nhiên liệu. Khung sườn chắc chắn, máy nổ êm ái, người bạn đồng hành đáng tin cậy nhất để khám phá thành phố.', 18,1,2,3),
('M00004','Yamaha Sirius RC','imageM4.jpg', '110cc', 'Phiên bản vành đúc thể thao của dòng xe Sirius huyền thoại. Trọng lượng nhẹ, dễ điều khiển, kiểu dáng trẻ trung năng động phù hợp với mọi độ tuổi.', 18,1,2,4),
('M00005','Yamaha YZF-R15',  'imageM5.jpg', '155cc', 'Siêu phẩm Sportbike thừa hưởng DNA từ R-Series danh tiếng. Tư thế ngồi đậm chất đua, động cơ VVA bức tốc kinh ngạc, thỏa mãn trọn vẹn đam mê tốc độ.', 18,1,6,9),
('M00006','Honda Air Blade', 'imageM6.jpg', '160cc', 'Sự kết hợp hoàn hảo giữa vẻ đẹp lịch lãm và khối động cơ eSP+ 160cc uy lực. Tiện ích ngập tràn, vận hành êm ru, biểu tượng của sự thành đạt.', 18,2,1,5),
('M00007','Honda Vario',     'imageM7.jpg', '125cc', 'Thiết kế góc cạnh, cá tính, phù hợp di chuyển linh hoạt trong phố đông. Động cơ eSP+ tiết kiệm xăng ưu việt, mang lại trải nghiệm lái êm ái hoàn hảo.', 18,2,1,3),
('M00008','Honda Future',    'imageM8.jpg', '125cc', 'Biểu tượng của sự bền bỉ bất diệt. Thiết kế thanh lịch, sang trọng cùng động cơ phun xăng điện tử PGM-FI tiết kiệm bậc nhất. Sự đầu tư kinh tế và thông minh.', 18,2,2,2),
('M00009','Honda Winner X',  'imageM9.jpg', '150cc', 'Chiến mã đường dài với thiết kế thể thao nam tính, động cơ DOHC 150cc đầm chắc, trang bị ABS an toàn tuyệt đối. Chinh phục mọi cung đèo hiểm trở.', 18,2,5,6),
('M00010','Honda CBR150R',   'imageM10.jpg','150cc', 'Thiết kế Sportbike hầm hố, tư thế lái phấn khích. Khối động cơ DOHC 6 cấp số mượt mà giúp bạn làm chủ tốc độ và mọi ánh nhìn trên từng kilomet đường.', 18,2,6,8),
('M00011','Suzuki RAIDER R150','imageM11.jpg','150cc','Ông vua tốc độ phân khúc Underbone. Thiết kế tối giản khí động học, động cơ DOHC 150cc bức tốc kinh ngạc, dành riêng cho những ai đam mê tốc độ thực thụ.', 18,3,5,8),
('M00012','Suzuki SATRIA F150','imageM12.jpg','150cc','Nhập khẩu nguyên chiếc với chất lượng gia công đỉnh cao. Hyper-underbone gọn nhẹ, linh hoạt, sức mạnh động cơ khiến mọi đối thủ phải dè chừng.', 18,3,5,8),
('M00013','Suzuki GSX R150', 'imageM13.jpg','150cc', 'Siêu mô tô thể thao phân khúc nhỏ có tỷ lệ sức mạnh/trọng lượng tốt nhất. Cầm lái GSX R150 là trải nghiệm cảm giác bước vào trường đua thực thụ.', 18,3,6,11),
('M00014','Sym Galaxy',      'imageM14.jpg','50cc',  'Thiết kế thể thao sắc sảo không cần bằng lái. Trọng lượng nhẹ, động cơ 50cc mượt mà an toàn, là phương tiện lý tưởng nhất cho học sinh, sinh viên.', 16,4,4,2),
('M00015','Sym Attila',      'imageM15.jpg','50cc',  'Vẻ đẹp hoài cổ, thanh lịch mang phong cách Châu Âu. Cốp cực rộng, lái siêu êm, sự lựa chọn dịu dàng và an toàn cho những buổi chiều dạo phố.', 16,4,4,1),
('M00016','Sym Elegant',     'imageM16.jpg','50cc',  'Thiết kế đúng như tên gọi - Vô cùng thanh lịch. Động cơ 50cc nhẹ nhàng, tiết kiệm xăng cực tốt, dễ dàng làm quen ngay cả với người chưa từng đi xe.', 16,4,4,1),
('M00017','VinFast Evo200',  'imageM17.jpg','50 kW', 'Mẫu xe máy điện quốc dân với thiết kế thời trang, công nghệ pin LFP đi xa đến 200km/lần sạc. Vận hành êm ru không tiếng ồn, thân thiện với môi trường.', 16,6,3,2),
('M00018','VinFast Klara S', 'imageM18.jpg','62 kW', 'Đẳng cấp xe điện thông minh mang đậm hơi thở Ý. Tính năng chống nước vượt trội, kết nối app mượt mà, định hình phong cách sống xanh và hiện đại.', 16,6,3,3),
('M00019','Piaggio Liberty', 'imageM19.jpg','150cc', 'Sự pha trộn hoàn hảo giữa vẻ đẹp thanh lịch của Ý và sự linh hoạt của xe ga đô thị. Động cơ iGet thế hệ mới êm ái, bứt tốc êm mượt vô cùng.', 18,5,1,7),
('M00020','Piaggio Medley',  'imageM20.jpg','150cc', 'Xe ga cao cấp bậc nhất với cốp siêu rộng chứa được 2 mũ fullface. Kiểu dáng sang trọng, công nghệ ngập tràn, khẳng định vị thế người cầm lái.', 18,5,1,6),
('M00021','Piaggio Fly',     'imageM21.jpg','120cc', 'Gọn gàng, dễ luồn lách nhưng vẫn toát lên vẻ cổ điển sang trọng. Chiếc xe hoàn hảo để đi dạo uống cafe sáng hay vi vu biển cùng người thương.', 16,5,1,3);

-- Motorcycle Detail (5 xe mỗi loại, 21 loại = 105 records)
INSERT INTO "Motorcycle Detail" ("MotorcycleID","LicensePlate") VALUES
('M00001','43 - B1 12345'),('M00001','43 - C1 67890'),('M00001','43 - D1 23456'),('M00001','43 - E1 28912'),('M00001','43 - F1 35267'),
('M00002','43 - G1 38122'),('M00002','43 - H1 25158'),('M00002','43 - K1 23223'),('M00002','43 - L1 02449'),('M00002','43 - B1 4680'),
('M00003','43 - C1 45191'),('M00003','43 - D1 4134'), ('M00003','43 - E1 45112'),('M00003','43 - F1 2478'), ('M00003','43 - G1 06023'),
('M00004','43 - H1 42689'),('M00004','43 - K1 21460'),('M00004','43 - L1 24147'),('M00004','43 - B1 2401'), ('M00004','43 - C1 11336'),
('M00005','43 - D1 64902'),('M00005','43 - E1 54257'),('M00005','43 - F1 86123'),('M00005','43 - G1 24678'),('M00005','43 - H1 24289'),
('M00006','43 - K1 32780'),('M00006','43 - L1 54991'),('M00006','43 - B1 35245'),('M00006','43 - C1 53356'),('M00006','43 - D1 43467'),
('M00007','43 - E1 4678'), ('M00007','43 - F1 64789'),('M00007','43 - G1 64890'),('M00007','43 - H1 34101'),('M00007','43 - K1 22302'),
('M00008','43 - L1 24023'),('M00008','43 - B1 24145'),('M00008','43 - C1 15256'),('M00008','43 - D1 24567'),('M00008','43 - E1 15358'),
('M00009','43 - F1 42179'),('M00009','43 - G1 29080'),('M00009','43 - H1 90205'),('M00009','43 - K1 35642'),('M00009','43 - L1 35213'),
('M00010','43 - B1 12346'),('M00010','43 - C1 12364'),('M00010','43 - D1 46367'),('M00010','43 - E1 53378'),('M00010','43 - F1 65349'),
('M00011','43 - G1 23590'),('M00011','43 - H1 45780'),('M00011','43 - K1 53912'),('M00011','43 - L1 53023'),('M00011','43 - B1 22245'),
('M00012','43 - C1 34356'),('M00012','43 - D1 34467'),('M00012','43 - E1 5578'), ('M00012','43 - F1 43689'),('M00012','43 - G1 43790'),
('M00013','43 - H1 23501'),('M00013','43 - K1 12412'),('M00013','43 - L1 12423'),('M00013','43 - B1 42245'),('M00013','43 - C1 42356'),
('M00014','43 - D1 32547'),('M00014','43 - E1 09778'),('M00014','43 - F1 05679'),('M00014','43 - G1 56790'),('M00014','43 - H1 97801'),
('M00015','43 - K1 32812'),('M00015','43 - L1 65123'),('M00015','43 - B1 26145'),('M00015','43 - C1 35456'),('M00015','43 - D1 65207'),
('M00016','43 - E1 58578'),('M00016','43 - F1 53679'),('M00016','43 - G1 22790'),('M00016','43 - H1 42891'),('M00016','43 - K1 24012'),
('M00017','43 - L1 24327'),('M00017','43 - B1 24545'),('M00017','43 - C1 24566'),('M00017','43 - D1 78567'),('M00017','43 - E1 55778'),
('M00018','43 - F1 44189'),('M00018','43 - G1 54370'),('M00018','43 - H1 24291'),('M00018','43 - K1 4205'), ('M00018','43 - L1 11313'),
('M00019','43 - M1 7831'), ('M00019','43 - A1 1560'), ('M00019','43 - E1 8591'), ('M00019','43 - K1 15405'),('M00019','43 - D1 19453'),
('M00020','43 - A1 44189'),('M00020','43 - K1 54371'),('M00020','43 - H1 24292'),('M00020','43 - K1 4206'), ('M00020','43 - L1 11314'),
('M00021','43 - A1 44191'),('M00021','43 - H1 54372'),('M00021','43 - E1 24293'),('M00021','43 - K1 4207'), ('M00021','43 - L1 11315');

-- Cập nhật trạng thái trực tiếp trong Motorcycle Detail (đã gộp Motorcycle Status vào đây)
UPDATE "Motorcycle Detail"
SET "CurrentStatus" = 'Đang thuê',
    "UpdatedByStaffID" = 'STAFF00001',
    "StatusUpdatedAt" = '2024-05-02 08:00:00',
    "StatusNote" = 'Đã cho thuê cho khách hàng'
WHERE "MotorcycleDetailID" IN (2,6,10,14,15,20,24,29);

UPDATE "Motorcycle Detail"
SET "CurrentStatus" = 'Bảo dưỡng',
    "UpdatedByStaffID" = 'STAFF00001',
    "StatusUpdatedAt" = '2024-05-04 08:00:00',
    "StatusNote" = 'Đang trong quá trình bảo dưỡng hoặc sửa chữa'
WHERE "MotorcycleDetailID" IN (4,7,12,17,23,27);

UPDATE "Motorcycle Detail"
SET "CurrentStatus" = 'Có sẵn',
    "UpdatedByStaffID" = 'STAFF00001',
    "StatusUpdatedAt" = '2024-05-01 08:00:00',
    "StatusNote" = 'Sẵn sàng cho thuê'
WHERE "MotorcycleDetailID" IN (1,3,5,8,9,11,13,16,18,19,21,22,25,26,28,30);

-- Booking Detail, Payment, Event, AccessoryDetail, TouristLocation
INSERT INTO "Booking Detail" ("MotorcycleDetailID","BookingID","TotalPrice") VALUES 
(1, 'BKTEST0001', 350000),
(3, 'BKTEST0002', 420000),
(5, 'BKTEST0003', 250000),
(8, 'BKTEST0004', 550000),
(9, 'BKTEST0005', 300000),
(11, 'BKTEST0006', 150000),
(13, 'BKTEST0007', 480000),
(16, 'BKTEST0008', 120000),
(18, 'BKTEST0009', 280000),
(19, 'BKTEST0010', 320000);
INSERT INTO "Payment" ("BookingID","PaymentMethod","PaymentDate","PaymentAmount","PaymentStatus") VALUES
('BKTEST0001', 'Chuyển khoản', '2026-05-02', 350000, 'Giao dịch thành công'),
('BKTEST0002', 'Tiền mặt',     '2026-05-05', 420000, 'Giao dịch thành công'),
('BKTEST0003', 'Tiền mặt',     '2026-05-08', 250000, 'Giao dịch thành công'),
('BKTEST0004', 'Chuyển khoản', '2026-05-12', 550000, 'Giao dịch thành công'),
('BKTEST0005', 'Tiền mặt',     '2026-05-15', 300000, 'Giao dịch thành công'),
('BKTEST0006', 'Tiền mặt',     '2026-05-18', 150000, 'Giao dịch thành công'),
('BKTEST0007', 'Chuyển khoản', '2026-05-22', 480000, 'Giao dịch thành công'),
('BKTEST0008', 'Tiền mặt',     '2026-05-26', 120000, 'Giao dịch thành công'),
('BKTEST0009', 'Tiền mặt',     '2026-05-29', 280000, 'Giao dịch thành công'),
('BKTEST0010', 'Chuyển khoản', '2026-06-01', 320000, 'Giao dịch thành công');
INSERT INTO "Event" ("EventTitle","CreatedDate","StartDate","EndDate","Content","EventImage","Discount","StaffID") VALUES
('Khuyến mãi mùa hè','2026-05-01','2026-06-01','2026-06-10','Giảm giá 5% cho tất cả các dòng xe trong tháng 6','imageEvent1.jpg',0.05,'STAFF00001');
INSERT INTO "AccessoryDetail" ("BookingID","AccessoryID","Quantity","TotalPrice") VALUES ('BKTEST0001',1,1,100000);
INSERT INTO "TouristLocation" ("LocationName","LocationImage","Description","UrlArticle","StaffID") VALUES
('Bà Nà Hills','imageTour1.jpg','Điểm du lịch nổi tiếng Đà Nẵng','https://banahills.sunworld.vn/en','STAFF00001'),
('Đèo Hải Vân','haivan_pass.png','Cung đường đèo tuyệt đẹp vắt ngang biển và mây, phù hợp xe khỏe và xe côn','https://vi.wikipedia.org/wiki/%C4%90%E1%BA%B7o_H%E1%BA%A3i_V%C3%A2n','STAFF00001'),
('Bán đảo Sơn Trà','sontra_peninsula.png','Lá phổi xanh của thành phố, cung đường ven biển ngắm Voọc chà vá chân nâu','https://vi.wikipedia.org/wiki/S%C6%A1n_Tr%C3%A0','STAFF00001'),
('Cầu Rồng Đà Nẵng', 'caurong_danang.png', 'Biểu tượng độc đáo của thành phố Đà Nẵng, phun lửa và nước vào mỗi dịp cuối tuần.', 'https://vi.wikipedia.org/wiki/C%E1%BA%A7u_R%E1%BB%93ng', 'STAFF00001'),
('Phố Cổ Hội An', 'hoian_ancient.png', 'Di sản văn hóa thế giới với những đêm đèn lồng huyền ảo, điểm đến lãng mạn cách Đà Nẵng 30km.', 'https://vi.wikipedia.org/wiki/Ph%E1%BB%91_c%E1%BB%95_H%E1%BB%99i_An', 'STAFF00001'),
('Ngũ Hành Sơn', 'nguhanhson.png', 'Danh thắng nổi tiếng với 5 ngọn núi đá vôi tuyệt đẹp và các hang động tâm linh huyền bí.', 'https://vi.wikipedia.org/wiki/Ng%C5%A9_H%C3%A0nh_S%C6%A1n', 'STAFF00001');

-- ====================================================================
-- BẢNG: LocationMotorcycleRecommendation (Tư duy Gợi ý Thông Minh)
-- ====================================================================

-- Xóa data cũ để chạy lại cho sạch sẽ
TRUNCATE TABLE "LocationMotorcycleRecommendation" RESTART IDENTITY CASCADE;

-- 1. BÁN ĐẢO SƠN TRÀ: Đường dốc cao, cua gấp, cấm xe tay ga. 
-- Giải pháp: Lọc "Xe số" và "Xe côn tay" để đổ đèo an toàn bằng phanh động cơ.
INSERT INTO "LocationMotorcycleRecommendation" ("LocationID", "MotorcycleID")
SELECT l."LocationID", m."MotorcycleID"
FROM "TouristLocation" l, "Motorcycle" m
JOIN "Category" c ON m."CategoryID" = c."CategoryID"
WHERE l."LocationName" ILIKE '%Sơn Trà%'
  AND c."CategoryName" IN ('Xe số', 'Xe côn tay');

-- 2. ĐÈO HẢI VÂN: Cung đường dài, đèo dốc hiểm trở. 
-- Giải pháp: Cần "Xe côn tay", "Xe phân khối lớn" hoặc "Xe số" để máy khỏe bám đường tốt.
INSERT INTO "LocationMotorcycleRecommendation" ("LocationID", "MotorcycleID")
SELECT l."LocationID", m."MotorcycleID"
FROM "TouristLocation" l, "Motorcycle" m
JOIN "Category" c ON m."CategoryID" = c."CategoryID"
WHERE l."LocationName" ILIKE '%Hải Vân%'
  AND c."CategoryName" IN ('Xe côn tay', 'Xe số', 'Xe phân khối lớn');

-- 3. PHỐ CỔ HỘI AN: Đi dạo phố, tấp lề liên tục.
-- Giải pháp: Ưu tiên "Xe tay ga" vì cốp rộng đựng đồ, dễ điều khiển, thời trang.
INSERT INTO "LocationMotorcycleRecommendation" ("LocationID", "MotorcycleID")
SELECT l."LocationID", m."MotorcycleID"
FROM "TouristLocation" l, "Motorcycle" m
JOIN "Category" c ON m."CategoryID" = c."CategoryID"
WHERE l."LocationName" ILIKE '%Hội An%'
  AND c."CategoryName" IN ('Xe tay ga');

-- 4. CẦU RỒNG ĐÀ NẴNG: Trung tâm thành phố, đông người, thường đi chơi tối.
-- Giải pháp: Xe nhỏ gọn, cốp rộng để cất mũ bảo hiểm khi đứng xem rồng phun lửa (Vision, Lead, Grande).
INSERT INTO "LocationMotorcycleRecommendation" ("LocationID", "MotorcycleID")
SELECT l."LocationID", m."MotorcycleID"
FROM "TouristLocation" l, "Motorcycle" m
JOIN "Category" c ON m."CategoryID" = c."CategoryID"
WHERE l."LocationName" ILIKE '%Cầu Rồng%'
  AND (c."CategoryName" = 'Xe tay ga' OR m."Model" ILIKE '%Vision%' OR m."Model" ILIKE '%Lead%');

-- 5. BÀ NÀ HILLS: Di chuyển trên quốc lộ bằng phẳng ra ngoại ô.
-- Giải pháp: Mặc dù đi ô tô/xe buýt là chính, nhưng nếu khách thích phượt xe máy thì cần xe tay ga đầm chắc, yên ái (như Air Blade, NVX) đỡ mỏi lưng.
INSERT INTO "LocationMotorcycleRecommendation" ("LocationID", "MotorcycleID")
SELECT l."LocationID", m."MotorcycleID"
FROM "TouristLocation" l, "Motorcycle" m
JOIN "Category" c ON m."CategoryID" = c."CategoryID"
WHERE l."LocationName" ILIKE '%Bà Nà%'
  AND (c."CategoryName" = 'Xe tay ga' OR m."Model" ILIKE '%Air Blade%' OR m."Model" ILIKE '%NVX%');

-- 6. NGŨ HÀNH SƠN: Khám phá hang động, di chuyển gần thành phố.
-- Giải pháp: Đa dụng, xe nào đi cũng được (Xe tay ga đô thị nhỏ gọn như Vision hoặc Xe số Sirius, Wave).
INSERT INTO "LocationMotorcycleRecommendation" ("LocationID", "MotorcycleID")
SELECT l."LocationID", m."MotorcycleID"
FROM "TouristLocation" l, "Motorcycle" m
WHERE l."LocationName" ILIKE '%Ngũ Hành%'
  AND (m."Model" ILIKE '%Vision%' OR m."Model" ILIKE '%Sirius%' OR m."Model" ILIKE '%Wave%');
  
-- GPSAlert
INSERT INTO "GPSAlert" ("MotorcycleDetailID","AlertType","Message","CreatedAt","Status") VALUES
(2,'Quá hạn trả xe','Xe 43 - C1 67890 đã quá hạn trả, cần liên hệ khách hàng.','2024-05-10 18:00:00','Chưa xử lý'),
(9,'Mất tín hiệu','Xe 43 - K1 23223 mất tín hiệu GPS trong 15 phút.','2024-05-09 11:30:00','Đã xử lý');

-- Demand & Demand_Detail
INSERT INTO "Demand" ("Demand") VALUES ('Đi chơi'),('Đi phượt'),('Đi làm'),('Đi học'),('Du lịch'),('Đi dã ngoại');
INSERT INTO "Demand_Detail" ("MotorcycleID","DemandId") VALUES
('M00001',1),('M00001',2),('M00001',3),('M00001',4),('M00001',5),
('M00002',1),('M00002',2),('M00002',3),('M00002',4),
('M00003',1),('M00003',2),('M00003',3),('M00003',4),
('M00004',1),('M00004',3),('M00004',4),
('M00005',1),('M00005',2),('M00005',4),('M00005',5),('M00005',6),
('M00006',1),('M00006',2),('M00006',3),('M00006',4),('M00006',5),('M00006',6),
('M00007',1),('M00007',3),('M00007',4),
('M00008',1),('M00008',3),('M00008',4),
('M00009',1),('M00009',2),('M00009',3),('M00009',4),
('M00010',1),('M00010',2),('M00010',3),('M00010',4),
('M00011',1),('M00011',3),('M00011',4),('M00011',5),
('M00012',1),('M00012',3),('M00012',4),
('M00013',1),('M00013',3),('M00013',4),('M00013',6),
('M00014',1),('M00014',3),('M00014',4),
('M00015',4),('M00016',4),
('M00017',1),('M00017',3),('M00017',4),
('M00018',1),('M00018',3),('M00018',4),('M00018',5),
('M00019',1),('M00019',2),('M00019',3),('M00019',4),('M00019',5),('M00019',6),
('M00020',2),('M00020',3),('M00020',5),('M00020',6),
('M00021',1),('M00021',3),('M00021',4);

-- DemandPriceRange
INSERT INTO "DemandPriceRange" ("MinPrice","MaxPrice") VALUES
(0,120000),(120000,150000),(150000,180000),(180000,210000),(210000,240000),(240000,270000),(270000,300000),(300000,NULL);