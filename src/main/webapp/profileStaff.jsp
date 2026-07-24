<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Thông tin cá nhân - SmartRide</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/newlogo_transparent.png">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/3.5.0/remixicon.min.css" rel="stylesheet">
    <style>
        :root {
            --gold: #b59349;
            --gold-dark: #9a7c3a;
            --gold-light: #d4af37;
            --dark: #1a1816;
            --bg: #f0f2f5;
            --card-shadow: 0 4px 24px rgba(0,0,0,0.08);
        }
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background: var(--bg);
            margin-top: 20px;
        }
        #main { padding-top: 20px; }

        /* ---- Profile header card ---- */
        .profile-hero {
            background: linear-gradient(135deg, #1a1816 0%, #2d2926 60%, #1a1816 100%);
            border-radius: 18px;
            padding: 32px;
            position: relative;
            overflow: hidden;
            box-shadow: var(--card-shadow);
        }
        .profile-hero::before {
            content: '';
            position: absolute;
            top: -60px; right: -60px;
            width: 200px; height: 200px;
            background: radial-gradient(circle, rgba(181,147,73,0.15) 0%, transparent 70%);
            border-radius: 50%;
        }
        .profile-hero::after {
            content: '';
            position: absolute;
            bottom: -40px; left: -40px;
            width: 150px; height: 150px;
            background: radial-gradient(circle, rgba(181,147,73,0.08) 0%, transparent 70%);
            border-radius: 50%;
        }
        .avatar-wrapper {
            position: relative;
            display: inline-block;
        }
        .avatar-circle {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--gold);
            box-shadow: 0 0 0 4px rgba(181,147,73,0.2);
            background: #333;
        }
        .avatar-upload-btn {
            position: absolute;
            bottom: 4px; right: 4px;
            width: 34px; height: 34px;
            background: var(--gold);
            border: 3px solid #fff;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer;
            transition: background 0.2s;
        }
        .avatar-upload-btn:hover { background: var(--gold-dark); }
        .avatar-upload-btn i { color: #fff; font-size: 14px; }
        .profile-name {
            font-size: 1.5rem;
            font-weight: 800;
            color: #fff;
            margin-bottom: 4px;
        }
        .profile-email { color: #94a3b8; font-size: 0.9rem; }
        .role-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(181,147,73,0.15);
            border: 1px solid rgba(181,147,73,0.35);
            color: var(--gold-light);
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        /* ---- Content card ---- */
        .content-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }

        /* ---- Custom Tabs ---- */
        .profile-tabs { border-bottom: 1px solid #e9ecef; padding: 0 24px; }
        .profile-tabs .nav-link {
            font-family: 'Be Vietnam Pro', sans-serif;
            font-weight: 600;
            font-size: 0.9rem;
            color: #94a3b8;
            padding: 16px 20px;
            border: none;
            border-bottom: 3px solid transparent;
            border-radius: 0;
            transition: all 0.25s;
        }
        .profile-tabs .nav-link:hover { color: var(--gold); }
        .profile-tabs .nav-link.active {
            color: var(--gold);
            border-bottom-color: var(--gold);
            background: transparent;
        }
        .profile-tabs .nav-link i { margin-right: 8px; font-size: 1rem; }

        /* ---- Form styling ---- */
        .tab-body { padding: 28px; }
        .form-label {
            font-weight: 600;
            font-size: 0.82rem;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }
        .form-control, .form-select {
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            padding: 10px 14px;
            font-size: 0.92rem;
            font-family: 'Be Vietnam Pro', sans-serif;
            color: #1a1816;
            transition: all 0.25s;
            background: #f8fafc;
        }
        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(181,147,73,0.12);
            background: #fff;
        }
        .form-control[readonly], .form-select[disabled] {
            background: #f1f5f9;
            color: #64748b;
            cursor: not-allowed;
        }
        .input-wrapper { position: relative; }
        .input-wrapper .form-control { padding-right: 44px; }
        .input-wrapper .eye-btn {
            position: absolute;
            top: 50%; right: 12px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #94a3b8;
            font-size: 1.1rem;
            transition: color 0.2s;
            border: none; background: transparent; padding: 0;
        }
        .input-wrapper .eye-btn:hover { color: var(--gold); }

        /* ---- Buttons ---- */
        .btn-gold {
            background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 100%);
            color: #fff;
            border: none;
            border-radius: 10px;
            padding: 10px 28px;
            font-weight: 700;
            font-size: 0.9rem;
            letter-spacing: 0.3px;
            transition: all 0.25s;
            box-shadow: 0 4px 14px rgba(181,147,73,0.3);
        }
        .btn-gold:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(181,147,73,0.4);
            color: #fff;
        }
        .btn-outline-gold {
            background: transparent;
            border: 2px solid var(--gold);
            color: var(--gold);
            border-radius: 10px;
            padding: 9px 24px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.25s;
        }
        .btn-outline-gold:hover {
            background: var(--gold);
            color: #fff;
        }

        /* ---- Password strength ---- */
        .strength-bar { height: 4px; border-radius: 4px; margin-top: 8px; transition: all 0.3s; }
        .strength-text { font-size: 0.78rem; font-weight: 600; margin-top: 4px; }
        .strength-weak  { background: #ef4444; }
        .strength-ok    { background: #f59e0b; }
        .strength-good  { background: #22c55e; }
        .text-strength-weak { color: #ef4444; }
        .text-strength-ok   { color: #f59e0b; }
        .text-strength-good { color: #22c55e; }

        /* ---- Alert messages ---- */
        .inline-msg {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 0.85rem;
            font-weight: 600;
            padding: 8px 16px;
            border-radius: 8px;
        }
        .inline-msg.success { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
        .inline-msg.error   { background: #fff1f2; color: #dc2626; border: 1px solid #fecaca; }

        /* ---- Stats row ---- */
        .stat-chip {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 14px 20px;
            text-align: center;
        }
        .stat-chip .num {
            font-size: 1.4rem;
            font-weight: 800;
            color: var(--gold);
        }
        .stat-chip .lbl {
            font-size: 0.78rem;
            color: #64748b;
            font-weight: 500;
        }

        /* ---- Section divider ---- */
        .section-divider {
            border: none;
            border-top: 1px solid #f1f5f9;
            margin: 24px 0;
        }

        /* ---- Responsive ---- */
        @media (max-width: 576px) {
            .profile-hero { padding: 20px; }
            .profile-hero .d-flex { flex-direction: column; align-items: center; text-align: center; gap: 16px; }
        }
    </style>
</head>
<body>

    <div class="container-fluid mt-4">
        <div class="container-fluid">
            <!-- Page title -->
            <div class="pagetitle mb-4">
                <h1 style="color:#1a1816; font-weight:800; font-size:22px; text-transform:uppercase; font-family:'Be Vietnam Pro',sans-serif;">Thông Tin Cá Nhân</h1>
                <nav>
                    <ol class="breadcrumb" style="background:transparent; padding:0; margin:0; font-size:13px;">
                        <li class="breadcrumb-item"><a href="homeStaff" target="_top" style="color:#b59349; text-decoration:none; font-weight:600;">Trang chủ</a></li>
                        <li class="breadcrumb-item active" style="color:#6c757d;">Thông tin cá nhân</li>
                    </ol>
                </nav>
            </div>

            <div class="row g-4" style="max-width:900px;">

                <!-- Profile Hero Card -->
                <div class="col-12">
                    <div class="profile-hero">
                        <div class="d-flex align-items-center gap-4">
                            <!-- Avatar -->
                            <div class="avatar-wrapper flex-shrink-0">
                                <img id="staff-profile-img"
                                     src="${not empty account.image ? account.image : 'images/default-avatar.png'}"
                                     alt="Avatar"
                                     class="avatar-circle"
                                     onerror="this.src='https://ui-avatars.com/api/?name=${account.firstName}+${account.lastName}&background=b59349&color=fff&size=110'">
                                <label class="avatar-upload-btn" title="Đổi ảnh đại diện">
                                    <i class="bi bi-camera-fill"></i>
                                    <input type="file" id="staffAvatarUpload" accept="image/*" style="display:none;">
                                </label>
                            </div>
                            <!-- Info -->
                            <div class="flex-grow-1 position-relative" style="z-index:1;">
                                <div class="profile-name">${account.firstName} ${account.lastName}</div>
                                <div class="profile-email mb-2">${account.email}</div>
                                <c:choose>
                                    <c:when test="${account.roleID == 3}">
                                        <span class="role-badge"><i class="bi bi-shield-check"></i> Quản Trị Viên</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="role-badge"><i class="bi bi-person-badge"></i> Nhân Viên</span>
                                    </c:otherwise>
                                </c:choose>
                                <div id="uploadSpinner" class="d-none mt-2">
                                    <div class="spinner-border spinner-border-sm text-warning" role="status">
                                        <span class="visually-hidden">Đang tải...</span>
                                    </div>
                                    <span class="text-warning ms-2 small">Đang cập nhật ảnh...</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Content Card -->
                <div class="col-12">
                    <div class="content-card">
                        <!-- Tabs -->
                        <ul class="nav profile-tabs" id="profileTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="info-tab" data-bs-toggle="tab" data-bs-target="#tab-info"
                                        type="button" role="tab">
                                    <i class="bi bi-person-circle"></i>Thông tin cá nhân
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="password-tab" data-bs-toggle="tab" data-bs-target="#tab-password"
                                        type="button" role="tab">
                                    <i class="bi bi-shield-lock"></i>Đổi mật khẩu
                                </button>
                            </li>
                        </ul>

                        <div class="tab-content" id="profileTabsContent">
                            <!-- ===== TAB THÔNG TIN CÁ NHÂN ===== -->
                            <div class="tab-pane fade show active tab-body" id="tab-info" role="tabpanel">
                                <form action="updateprofile" method="post" id="form-update">
                                    <input type="hidden" name="accountID" value="${account.accountId}">
                                    <input type="hidden" name="roleID" value="${account.roleID}">

                                    <!-- Họ tên (readonly hiển thị) -->
                                    <div id="div-fullname" class="mb-4">
                                        <label class="form-label">Họ và tên</label>
                                        <input class="form-control" id="account-fullname"
                                               value="${account.firstName} ${account.lastName}" readonly>
                                    </div>
                                    <!-- Họ + Tên riêng (ẩn, hiện khi chỉnh sửa) -->
                                    <div class="row g-3 mb-4" id="div-splitname" style="display:none !important;">
                                        <div class="col-md-6">
                                            <label class="form-label">Họ, tên đệm</label>
                                            <input class="form-control" name="firstname" id="account-firstname"
                                                   value="${account.firstName}">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Tên</label>
                                            <input class="form-control" name="lastname" id="account-lastname"
                                                   value="${account.lastName}">
                                        </div>
                                    </div>

                                    <hr class="section-divider">

                                    <div class="row g-3 mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label">Email</label>
                                            <input class="form-control" name="email" type="email"
                                                   id="account-email" value="${account.email}" readonly>
                                            <span class="strength-text" id="email-text"></span>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Số điện thoại</label>
                                            <input class="form-control" name="phonenumber" type="text"
                                                   id="account-phone" value="${account.phoneNumber}" readonly>
                                            <span class="strength-text" id="numphone-text"></span>
                                        </div>
                                    </div>

                                    <div class="row g-3 mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label">Tên đăng nhập</label>
                                            <input class="form-control" name="username" id="account-username"
                                                   value="${account.userName}" readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Địa chỉ</label>
                                            <input class="form-control" name="address" id="account-address"
                                                   value="${account.address}" readonly>
                                        </div>
                                    </div>

                                    <div class="row g-3 mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label">Giới tính</label>
                                            <select class="form-select" name="gender" id="account-gender" disabled>
                                                <option value="Nam" ${account.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                                <option value="Nữ" ${account.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                                <option value="Không muốn tiết lộ" ${account.gender == 'Không muốn tiết lộ' ? 'selected' : ''}>Không muốn tiết lộ</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Ngày sinh</label>
                                            <input class="form-control" name="dob" type="date"
                                                   id="account-dob" value="${account.dob}" readonly>
                                        </div>
                                    </div>

                                    <hr class="section-divider">

                                    <div class="d-flex align-items-center gap-3 flex-wrap">
                                        <button onclick="changeType(this)" id="update"
                                                class="btn-gold" type="button">
                                            <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa
                                        </button>
                                        <c:if test="${not empty requestScope.mess}">
                                            <span class="inline-msg success">
                                                <i class="bi bi-check-circle-fill"></i>${mess}
                                            </span>
                                        </c:if>
                                        <c:if test="${not empty requestScope.errorProfile}">
                                            <span class="inline-msg error">
                                                <i class="bi bi-exclamation-circle-fill"></i>${requestScope.errorProfile}
                                            </span>
                                        </c:if>
                                    </div>
                                </form>
                            </div>

                            <!-- ===== TAB ĐỔI MẬT KHẨU ===== -->
                            <div class="tab-pane fade tab-body" id="tab-password" role="tabpanel">
                                <form action="changepassword" method="post" id="signupForm" novalidate>
                                    <div class="mb-4" style="max-width:480px;">
                                        <label class="form-label">Mật khẩu hiện tại</label>
                                        <input type="hidden" id="currentpass" value="${account.passWord}">
                                        <div class="input-wrapper">
                                            <input type="password" class="form-control" id="password" name="password" required
                                                   placeholder="Nhập mật khẩu hiện tại">
                                            <button type="button" class="eye-btn" onclick="showPassword('password', this)">
                                                <i class="ri-eye-off-line"></i>
                                            </button>
                                        </div>
                                        <span class="strength-text" id="password-text"></span>
                                    </div>

                                    <div class="mb-4" style="max-width:480px;">
                                        <label class="form-label">Mật khẩu mới</label>
                                        <div class="input-wrapper">
                                            <input type="password" class="form-control" id="newPassword" name="newPassword" required
                                                   placeholder="Tối thiểu 6 ký tự">
                                            <button type="button" class="eye-btn" onclick="showPassword('newPassword', this)">
                                                <i class="ri-eye-off-line"></i>
                                            </button>
                                        </div>
                                        <div class="strength-bar d-none" id="strength-bar"></div>
                                        <span class="strength-text" id="password-strength"></span>
                                    </div>

                                    <div class="mb-4" style="max-width:480px;">
                                        <label class="form-label">Xác nhận mật khẩu mới</label>
                                        <div class="input-wrapper">
                                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required
                                                   placeholder="Nhập lại mật khẩu mới">
                                            <button type="button" class="eye-btn" onclick="showPassword('confirmPassword', this)">
                                                <i class="ri-eye-off-line"></i>
                                            </button>
                                        </div>
                                        <span class="strength-text" id="password-confirmText"></span>
                                    </div>

                                    <hr class="section-divider" style="max-width:480px;">

                                    <div class="d-flex align-items-center gap-3 flex-wrap">
                                        <button class="btn-gold" type="submit">
                                            <i class="bi bi-shield-check me-2"></i>Đổi mật khẩu
                                        </button>
                                        <c:if test="${not empty requestScope.errorPass}">
                                            <span class="inline-msg error">
                                                <i class="bi bi-exclamation-circle-fill"></i>${errorPass}
                                            </span>
                                        </c:if>
                                        <c:if test="${not empty requestScope.successChange}">
                                            <span class="inline-msg success">
                                                <i class="bi bi-check-circle-fill"></i>${successChange}
                                            </span>
                                        </c:if>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!-- /row -->
        </div>
    </div>

    <script src="staffAssets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="staffAssets/js/main.js"></script>
    <script>
        // ===== CHỈNH SỬA / LƯU thông tin =====
        function changeType(button) {
            var inputs = document.querySelectorAll('#form-update .form-control');
            if (button.id === 'update') {
                // Chuyển sang chế độ chỉnh sửa
                button.id = 'save';
                button.innerHTML = '<i class="bi bi-floppy me-2"></i>Lưu thay đổi';
                inputs.forEach(inp => {
                    if (inp.name !== 'pass' && inp.id !== 'account-fullname' && inp.id !== 'account-username') {
                        inp.readOnly = false;
                        inp.style.background = '#fff';
                        inp.style.cursor = 'text';
                    }
                });
                document.getElementById('account-gender').disabled = false;
                document.getElementById('div-splitname').style.setProperty('display', 'flex', 'important');
                document.getElementById('div-fullname').style.display = 'none';
            } else {
                // Submit
                document.getElementById('form-update').submit();
            }
        }

        // ===== SHOW/HIDE PASSWORD =====
        function showPassword(inputId, btn) {
            const input = document.getElementById(inputId);
            const icon = btn.querySelector('i');
            if (input.type === 'password') {
                input.type = 'text';
                icon.className = 'ri-eye-line';
            } else {
                input.type = 'password';
                icon.className = 'ri-eye-off-line';
            }
        }

        // ===== PASSWORD STRENGTH =====
        const newPassInput   = document.getElementById('newPassword');
        const confirmInput   = document.getElementById('confirmPassword');
        const strengthBar    = document.getElementById('strength-bar');
        const strengthText   = document.getElementById('password-strength');
        const confirmText    = document.getElementById('password-confirmText');
        const currentPassEl  = document.getElementById('currentpass');
        const valuePassEl    = document.getElementById('password');
        const passText       = document.getElementById('password-text');

        valuePassEl.addEventListener('input', () => {
            if (valuePassEl.value && valuePassEl.value !== currentPassEl.value) {
                passText.textContent  = 'Mật khẩu hiện tại không đúng';
                passText.className    = 'strength-text text-strength-weak';
            } else {
                passText.textContent = '';
            }
        });

        newPassInput.addEventListener('input', () => {
            const len = newPassInput.value.length;
            strengthBar.classList.remove('d-none');
            strengthBar.className = 'strength-bar ';
            if (len === 0) {
                strengthBar.classList.add('d-none');
                strengthText.textContent = '';
                return;
            }
            if (len >= 12) {
                strengthBar.classList.add('strength-good');
                strengthText.textContent = '✅ Mật khẩu mạnh';
                strengthText.className = 'strength-text text-strength-good';
            } else if (len >= 9) {
                strengthBar.classList.add('strength-ok');
                strengthText.textContent = '⚠️ Mật khẩu vừa';
                strengthText.className = 'strength-text text-strength-ok';
            } else if (len >= 6) {
                strengthBar.classList.add('strength-weak');
                strengthText.textContent = '❌ Mật khẩu yếu';
                strengthText.className = 'strength-text text-strength-weak';
            } else {
                strengthBar.classList.add('strength-weak');
                strengthText.textContent = 'Cần ít nhất 6 ký tự';
                strengthText.className = 'strength-text text-strength-weak';
            }
        });

        confirmInput.addEventListener('input', () => {
            if (confirmInput.value && confirmInput.value !== newPassInput.value) {
                confirmText.textContent = '❌ Mật khẩu xác nhận không khớp';
                confirmText.className = 'strength-text text-strength-weak';
            } else if (confirmInput.value) {
                confirmText.textContent = '✅ Khớp';
                confirmText.className = 'strength-text text-strength-good';
            } else {
                confirmText.textContent = '';
            }
        });

        // ===== EMAIL & PHONE VALIDATION =====
        const emailInput  = document.getElementById('account-email');
        const emailText   = document.getElementById('email-text');
        const phoneInput  = document.getElementById('account-phone');
        const phoneText   = document.getElementById('numphone-text');
        const emailRegex  = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const phoneRegex  = /^0\d{9}$/;

        emailInput.addEventListener('input', () => {
            if (!emailInput.readOnly) {
                emailText.textContent = emailRegex.test(emailInput.value.trim())
                    ? '' : 'Email chưa đúng định dạng.';
                emailText.className = 'strength-text text-strength-weak';
            }
        });
        phoneInput.addEventListener('input', () => {
            if (!phoneInput.readOnly) {
                phoneText.textContent = phoneRegex.test(phoneInput.value)
                    ? '' : 'SĐT phải có 10 số, bắt đầu bằng 0.';
                phoneText.className = 'strength-text text-strength-weak';
            }
        });

        // ===== AVATAR UPLOAD =====
        document.addEventListener('DOMContentLoaded', function() {
            // Restore tab state
            const savedTab = localStorage.getItem('profileActiveTab');
            if (savedTab) {
                const tabEl = document.getElementById(savedTab);
                if (tabEl) new bootstrap.Tab(tabEl).show();
            }
            document.querySelectorAll('#profileTabs .nav-link').forEach(btn => {
                btn.addEventListener('click', () => localStorage.setItem('profileActiveTab', btn.id));
            });

            // Upload
            const avatarUpload = document.getElementById('staffAvatarUpload');
            if (avatarUpload) {
                avatarUpload.addEventListener('change', function(e) {
                    const file = e.target.files[0];
                    if (!file) return;
                    const spinner = document.getElementById('uploadSpinner');
                    spinner.classList.remove('d-none');

                    const id = '${account.accountId}';
                    const formData = new FormData();
                    formData.append('file', file, file.name);
                    formData.append('id', id);

                    fetch('uploadimage', { method: 'POST', body: formData })
                        .then(res => {
                            if (res.ok) { window.location.reload(); }
                            else { alert('Có lỗi khi cập nhật ảnh!'); spinner.classList.add('d-none'); }
                        })
                        .catch(() => { alert('Lỗi kết nối!'); spinner.classList.add('d-none'); });
                });
            }
        });
    </script>
</body>
</html>
