<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản Lý Xe Máy - SmartRide</title>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="description">
        <meta content="" name="keywords">

        <!-- Favicons -->
        <link href="${pageContext.request.contextPath}/images/newlogo_transparent.png" rel="icon" type="image/png">
        

        <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">
        <link
            href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
            rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="staffAssets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="staffAssets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="staffAssets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="staffAssets/vendor/quill/quill.snow.css" rel="stylesheet">
        <link href="staffAssets/vendor/quill/quill.bubble.css" rel="stylesheet">
        <link href="staffAssets/vendor/remixicon/remixicon.css" rel="stylesheet">
        <link href="staffAssets/vendor/simple-datatables/style.css" rel="stylesheet">

        <!-- Template Main CSS File -->
        <link href="staffAssets/css/style.css" rel="stylesheet">
    </head>
    <body style="overflow: hidden;">
        <jsp:include page="/includes/staff/header-staff.jsp" />
        <jsp:include page="/includes/staff/sidebar.jsp" />
        


        <main id="main" class="main" style="padding: 0; position: relative;">
            <iframe id="contentIframe" onload="if(window.NProgress) window.NProgress.done();" src="${param.iframeSrc}${param.iframeSrc.contains('?') ? '&' : '?'}iframe=true" style="width: 100%; height: calc(100vh - 60px); border: none;" scrolling="yes"></iframe>
        </main>
        
        <!-- Vendor JS Files -->
        <!-- Global Lightbox Modal -->
        <div class="modal fade" id="globalLightboxModal" tabindex="-1" aria-hidden="true" style="z-index: 1060;">
            <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 90vw;">
                <div class="modal-content" style="background: transparent; border: none; box-shadow: none;">
                    <div class="modal-header" style="border: none; position: absolute; right: 0; z-index: 1070;">
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close" style="background-color: rgba(0,0,0,0.5); border-radius: 50%; padding: 10px; margin: 10px;"></button>
                    </div>
                    <div class="modal-body text-center p-0" style="position: relative;">
                        <img id="globalLightboxImage" src="" alt="Enlarged Image" style="max-width: 100%; max-height: 90vh; object-fit: contain; border-radius: 8px; box-shadow: 0 10px 25px rgba(0,0,0,0.5);">
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            // Global function to open lightbox, callable from iframes via window.parent.openLightbox(src)
            window.openLightbox = function(imageSrc) {
                if (!imageSrc || imageSrc === '#' || imageSrc.includes('no-image')) return;
                const lightboxImage = document.getElementById('globalLightboxImage');
                if (lightboxImage) {
                    lightboxImage.src = imageSrc;
                    const lightboxModal = new bootstrap.Modal(document.getElementById('globalLightboxModal'));
                    lightboxModal.show();
                }
            };
        </script>

        <script src="staffAssets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="staffAssets/vendor/simple-datatables/simple-datatables.js"></script>
        <script src="staffAssets/vendor/tinymce/tinymce.min.js"></script>
        <!-- Template Main JS File -->
        <script src="staffAssets/js/main.js"></script>
    </body>
</html>
