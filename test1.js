
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelectorAll(".sidebar-link").forEach(function (sidebarLink) {
                    sidebarLink.addEventListener("click", function () {
                        var targetTab = sidebarLink.getAttribute("data-target-tab");
                        document.querySelector(targetTab).click();
                    });
                });

                // Add event listeners for radio buttons
                document.querySelectorAll(".custom-control-input").forEach(function (radio) {
                    radio.addEventListener("change", function () {
                        var value = radio.value;
                        document.querySelector('[data-target-tab="#tab-' + value + '"]').click();
                    });
                });
            });
        
