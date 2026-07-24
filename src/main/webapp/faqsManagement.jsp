<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản Lý Câu Hỏi Thường Gặp</title>

    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <!-- Google Fonts: Be Vietnam Pro -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background: #f0f2f5;
            min-height: 100vh;
            padding: 28px 24px 48px;
            color: #1a1a2e;
        }

        /* ─── Page header ─────────────────────────────── */
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 14px;
            margin-bottom: 28px;
        }
        .page-header-left h1 {
            font-size: 1.45rem;
            font-weight: 800;
            color: #1a1a2e;
            letter-spacing: -.3px;
            margin-bottom: 4px;
        }
        .breadcrumb {
            background: transparent;
            padding: 0;
            margin: 0;
            font-size: .8rem;
        }
        .breadcrumb-item a {
            color: #b59349;
            text-decoration: none;
        }
        .breadcrumb-item.active { color: #6c757d; }
        .breadcrumb-item + .breadcrumb-item::before { color: #adb5bd; }

        /* ─── Add button ──────────────────────────────── */
        .btn-add-faq {
            background: linear-gradient(135deg, #b59349 0%, #d4af37 60%, #f1c40f 100%);
            color: #fff;
            font-family: 'Be Vietnam Pro', sans-serif;
            font-weight: 700;
            font-size: .875rem;
            border: none;
            border-radius: 10px;
            padding: 10px 22px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(181,147,73,.35);
            transition: transform .2s, box-shadow .2s;
            text-shadow: 0 1px 2px rgba(0,0,0,.18);
        }
        .btn-add-faq:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 22px rgba(181,147,73,.45);
            color: #fff;
        }
        .btn-add-faq:active { transform: translateY(0); }

        /* ─── Stats strip ─────────────────────────────── */
        .stats-strip {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 22px;
            font-size: .82rem;
            color: #6c757d;
            font-weight: 500;
        }
        .stats-badge {
            background: linear-gradient(135deg, #b59349, #d4af37);
            color: #fff;
            font-size: .75rem;
            font-weight: 700;
            padding: 3px 10px;
            border-radius: 50px;
        }

        /* ─── Empty state ─────────────────────────────── */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 16px rgba(0,0,0,.06);
        }
        .empty-state .empty-icon {
            width: 80px; height: 80px;
            background: linear-gradient(135deg, #b59349, #f1c40f);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem; color: #fff;
        }
        .empty-state h5 { font-weight: 700; color: #1a1a2e; margin-bottom: 8px; }
        .empty-state p { color: #6c757d; font-size: .9rem; }

        /* ─── FAQ Card ────────────────────────────────── */
        .faq-card {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 12px rgba(0,0,0,.07);
            padding: 20px 22px;
            display: flex;
            align-items: flex-start;
            gap: 18px;
            border: 1.5px solid transparent;
            transition: transform .22s cubic-bezier(.34,1.56,.64,1), box-shadow .22s, border-color .22s;
            animation: fadeSlideUp .4s ease both;
        }
        .faq-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 28px rgba(181,147,73,.18);
            border-color: rgba(181,147,73,.35);
        }

        @keyframes fadeSlideUp {
            from { opacity: 0; transform: translateY(18px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* stagger children */
        .faq-list .faq-card:nth-child(1)  { animation-delay: .05s; }
        .faq-list .faq-card:nth-child(2)  { animation-delay: .10s; }
        .faq-list .faq-card:nth-child(3)  { animation-delay: .15s; }
        .faq-list .faq-card:nth-child(4)  { animation-delay: .20s; }
        .faq-list .faq-card:nth-child(5)  { animation-delay: .25s; }
        .faq-list .faq-card:nth-child(6)  { animation-delay: .30s; }
        .faq-list .faq-card:nth-child(7)  { animation-delay: .35s; }
        .faq-list .faq-card:nth-child(8)  { animation-delay: .40s; }
        .faq-list .faq-card:nth-child(n+9){ animation-delay: .45s; }

        /* Question mark badge */
        .faq-icon-badge {
            flex-shrink: 0;
            width: 46px; height: 46px;
            background: linear-gradient(135deg, #b59349 0%, #d4af37 50%, #f1c40f 100%);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.2rem; color: #fff;
            box-shadow: 0 4px 12px rgba(181,147,73,.3);
            margin-top: 2px;
        }

        /* Text area */
        .faq-body { flex: 1; min-width: 0; }
        .faq-index {
            font-size: .7rem;
            font-weight: 700;
            color: #b59349;
            text-transform: uppercase;
            letter-spacing: .8px;
            margin-bottom: 4px;
        }
        .faq-question {
            font-size: .97rem;
            font-weight: 700;
            color: #1a1a2e;
            line-height: 1.45;
            margin-bottom: 7px;
            word-break: break-word;
        }
        .faq-answer {
            font-size: .855rem;
            color: #6c757d;
            line-height: 1.6;
            word-break: break-word;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* Action buttons */
        .faq-actions {
            display: flex;
            flex-direction: column;
            gap: 8px;
            flex-shrink: 0;
        }
        .btn-icon {
            width: 36px; height: 36px;
            border-radius: 9px;
            border: none;
            display: flex; align-items: center; justify-content: center;
            font-size: .85rem;
            cursor: pointer;
            transition: transform .18s, box-shadow .18s;
        }
        .btn-icon:hover { transform: scale(1.1); box-shadow: 0 4px 12px rgba(0,0,0,.15); }
        .btn-edit  { background: #e8f4fd; color: #0d6efd; }
        .btn-edit:hover  { background: #0d6efd; color: #fff; }
        .btn-delete{ background: #fde8e8; color: #dc3545; }
        .btn-delete:hover{ background: #dc3545; color: #fff; }

        /* ─── Modals ──────────────────────────────────── */
        .modal-header-gold {
            background: linear-gradient(135deg, #b59349 0%, #d4af37 60%, #f1c40f 100%);
            border-radius: 12px 12px 0 0;
            padding: 18px 24px;
        }
        .modal-header-gold .modal-title {
            font-family: 'Be Vietnam Pro', sans-serif;
            font-weight: 800;
            color: #fff;
            font-size: 1rem;
            text-shadow: 0 1px 3px rgba(0,0,0,.2);
            display: flex; align-items: center; gap: 10px;
        }
        .modal-header-gold .btn-close {
            filter: invert(1) brightness(2);
            opacity: .85;
        }
        .modal-content {
            border-radius: 14px;
            border: none;
            box-shadow: 0 20px 60px rgba(0,0,0,.18);
            font-family: 'Be Vietnam Pro', sans-serif;
        }
        .modal-body { padding: 24px; }
        .modal-footer { padding: 16px 24px; border-top: 1px solid #f0f2f5; }

        .form-label {
            font-weight: 600;
            font-size: .82rem;
            color: #3d3d5c;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: .5px;
        }
        .form-control, .form-select {
            font-family: 'Be Vietnam Pro', sans-serif;
            font-size: .88rem;
            border-radius: 9px;
            border: 1.5px solid #e2e8f0;
            padding: 10px 14px;
            transition: border-color .2s, box-shadow .2s;
            color: #1a1a2e;
        }
        .form-control:focus, .form-select:focus {
            border-color: #d4af37;
            box-shadow: 0 0 0 3px rgba(212,175,55,.18);
            outline: none;
        }
        textarea.form-control { resize: vertical; min-height: 110px; }

        .btn-gold {
            background: linear-gradient(135deg, #b59349, #d4af37);
            color: #fff;
            font-family: 'Be Vietnam Pro', sans-serif;
            font-weight: 700;
            font-size: .875rem;
            border: none;
            border-radius: 9px;
            padding: 10px 24px;
            cursor: pointer;
            box-shadow: 0 3px 12px rgba(181,147,73,.3);
            transition: transform .18s, box-shadow .18s;
        }
        .btn-gold:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 18px rgba(181,147,73,.4);
            color: #fff;
        }
        .btn-cancel {
            font-family: 'Be Vietnam Pro', sans-serif;
            font-weight: 600;
            font-size: .875rem;
            border-radius: 9px;
            padding: 10px 20px;
        }

        /* ─── Divider between cards ───────────────────── */
        .faq-list { display: flex; flex-direction: column; gap: 14px; }

        /* ─── Scrollbar polish ────────────────────────── */
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-track { background: #f0f2f5; }
        ::-webkit-scrollbar-thumb { background: #d4af37; border-radius: 3px; }
    </style>
</head>
<body>

<!-- ══════════════════════════════════════════
     PAGE HEADER
═══════════════════════════════════════════ -->
<div class="page-header">
    <div class="page-header-left">
        <h1><i class="fa-solid fa-circle-question me-2" style="color:#b59349;"></i>Quản Lý Câu Hỏi Thường Gặp</h1>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#"><i class="fa-solid fa-house-chimney me-1"></i>Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">FAQ</li>
            </ol>
        </nav>
    </div>
    <button class="btn-add-faq" data-bs-toggle="modal" data-bs-target="#addFaqModal">
        <i class="fa-solid fa-plus"></i> Thêm FAQ
    </button>
</div>

<!-- Stats strip -->
<div class="stats-strip">
    <i class="fa-solid fa-layer-group" style="color:#b59349;"></i>
    Tổng số câu hỏi:
    <span class="stats-badge">${empty faqs ? 0 : faqs.size()}</span>
</div>

<!-- ══════════════════════════════════════════
     FAQ LIST
═══════════════════════════════════════════ -->
<c:choose>
    <c:when test="${empty faqs}">
        <div class="empty-state">
            <div class="empty-icon"><i class="fa-solid fa-circle-question"></i></div>
            <h5>Chưa có câu hỏi nào</h5>
            <p>Nhấn "+ Thêm FAQ" để tạo câu hỏi thường gặp đầu tiên.</p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="faq-list">
            <c:forEach var="faq" items="${faqs}" varStatus="status">
                <div class="faq-card">
                    <!-- Icon badge -->
                    <div class="faq-icon-badge">
                        <i class="fa-solid fa-question"></i>
                    </div>

                    <!-- Content -->
                    <div class="faq-body">
                        <div class="faq-index">Câu hỏi #${status.index + 1}</div>
                        <div class="faq-question">${faq.question}</div>
                        <div class="faq-answer">${faq.answer}</div>
                    </div>

                    <!-- Actions -->
                    <div class="faq-actions">
                        <!-- Edit button -->
                        <button class="btn-icon btn-edit"
                                title="Chỉnh sửa"
                                data-bs-toggle="modal"
                                data-bs-target="#editFaqModal"
                                onclick="loadEditModal('${faq.questionID}', `${faq.question}`, `${faq.answer}`)">
                            <i class="fa-solid fa-pen-to-square"></i>
                        </button>
                        <!-- Delete button -->
                        <button class="btn-icon btn-delete"
                                title="Xoá"
                                onclick="confirmDelete(${faq.questionID})">
                            <i class="fa-solid fa-trash-can"></i>
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>


<!-- ══════════════════════════════════════════
     ADD FAQ MODAL
═══════════════════════════════════════════ -->
<div class="modal fade" id="addFaqModal" tabindex="-1" aria-labelledby="addFaqModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header-gold">
                <div class="modal-title" id="addFaqModalLabel">
                    <i class="fa-solid fa-plus-circle"></i> Thêm Câu Hỏi Thường Gặp
                </div>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <form action="faqsStaff" method="post">
                <div class="modal-body">
                    <div class="mb-4">
                        <label for="addQuestion" class="form-label">
                            <i class="fa-solid fa-circle-question me-1" style="color:#b59349;"></i>Câu hỏi
                        </label>
                        <input type="text"
                               class="form-control"
                               id="addQuestion"
                               name="question"
                               placeholder="Nhập câu hỏi thường gặp..."
                               required />
                    </div>
                    <div class="mb-2">
                        <label for="addAnswer" class="form-label">
                            <i class="fa-solid fa-message me-1" style="color:#b59349;"></i>Câu trả lời
                        </label>
                        <textarea class="form-control"
                                  id="addAnswer"
                                  name="answer"
                                  placeholder="Nhập câu trả lời chi tiết..."
                                  required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light btn-cancel" data-bs-dismiss="modal">
                        <i class="fa-solid fa-xmark me-1"></i>Huỷ
                    </button>
                    <button type="submit" class="btn-gold">
                        <i class="fa-solid fa-floppy-disk me-1"></i>Lưu FAQ
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- ══════════════════════════════════════════
     EDIT FAQ MODAL
═══════════════════════════════════════════ -->
<div class="modal fade" id="editFaqModal" tabindex="-1" aria-labelledby="editFaqModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header-gold">
                <div class="modal-title" id="editFaqModalLabel">
                    <i class="fa-solid fa-pen-to-square"></i> Chỉnh Sửa Câu Hỏi
                </div>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <form action="UpdateFAQsServletStaff" method="post">
                <div class="modal-body">
                    <input type="hidden" id="editQuestionID" name="questionID" />

                    <div class="mb-4">
                        <label for="editQuestion" class="form-label">
                            <i class="fa-solid fa-circle-question me-1" style="color:#b59349;"></i>Câu hỏi
                        </label>
                        <input type="text"
                               class="form-control"
                               id="editQuestion"
                               name="question"
                               placeholder="Nhập câu hỏi..."
                               required />
                    </div>
                    <div class="mb-2">
                        <label for="editAnswer" class="form-label">
                            <i class="fa-solid fa-message me-1" style="color:#b59349;"></i>Câu trả lời
                        </label>
                        <textarea class="form-control"
                                  id="editAnswer"
                                  name="answer"
                                  placeholder="Nhập câu trả lời..."
                                  required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light btn-cancel" data-bs-dismiss="modal">
                        <i class="fa-solid fa-xmark me-1"></i>Huỷ
                    </button>
                    <button type="submit" class="btn-gold">
                        <i class="fa-solid fa-floppy-disk me-1"></i>Cập nhật
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- ══════════════════════════════════════════
     SCRIPTS
═══════════════════════════════════════════ -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    /* ── Populate edit modal ─────────────────────── */
    function loadEditModal(id, question, answer) {
        document.getElementById('editQuestionID').value = id;
        document.getElementById('editQuestion').value   = question;
        document.getElementById('editAnswer').value     = answer;
    }

    /* ── Delete with SweetAlert2 ─────────────────── */
    function confirmDelete(questionID) {
        Swal.fire({
            title: 'Xác nhận xoá?',
            text: 'Câu hỏi này sẽ bị xoá vĩnh viễn và không thể khôi phục.',
            icon: 'warning',
            iconColor: '#b59349',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '<i class="fa fa-trash me-1"></i> Xoá ngay',
            cancelButtonText: 'Huỷ bỏ',
            customClass: {
                popup:          'swal-font',
                title:          'swal-title',
                confirmButton:  'swal-confirm',
                cancelButton:   'swal-cancel'
            },
            didOpen: () => {
                /* inject font into SweetAlert popup */
                const popup = Swal.getPopup();
                if (popup) popup.style.fontFamily = "'Be Vietnam Pro', sans-serif";
            }
        }).then(result => {
            if (result.isConfirmed) {
                window.location.href = 'deleteFAQs?questionID=' + questionID;
            }
        });
    }
</script>
</body>
</html>
